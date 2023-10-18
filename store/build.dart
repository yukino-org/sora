import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utils.dart';
import 'core/module.dart';
import 'core/modules.dart';
import 'utils/paths.dart';

class SBuilder {
  final DateTime now = DateTime.now();

  final Map<String, TenkaMetadata> modules = <String, TenkaMetadata>{};
  final Map<String, String> clonedRepos = <String, String>{};

  Future<void> initialize() async {
    await TenkaDevEnvironment.prepare();
  }

  Future<void> build() async {
    await FSUtils.recreateDirectory(Directory(Paths.distDir));
    await FSUtils.recreateDirectory(Directory(Paths.distDataDir));

    final List<SBaseModule<dynamic>> storeModules = <SBaseModule<dynamic>>[
      ...SModules.anime,
      ...SModules.manga,
    ];
    for (final SBaseModule<dynamic> x in storeModules) {
      await _loadMetadata(x);
    }

    final TenkaStore store = TenkaStore(
      baseURLs: <String, String>{
        // TODO: fix this
        'github': '',
      },
      modules: modules,
      builtAt: now,
      checksum: TenkaStore.generateChecksum(),
    );
    await File(p.join(Paths.distDir, 'store.json'))
        .writeAsString(json.encode(store.toJson()));
    await File(p.join(Paths.distDir, 'store.sha256'))
        .writeAsString(store.checksum);
  }

  Future<void> dispose() async {
    await TenkaDevEnvironment.dispose();
  }

  Future<void> _loadMetadata(final SBaseModule<dynamic> x) async {
    final SGeneratedConfig? generatedConfig = await x.generatedConfig();
    final TenkaMetadata config = await x.config();
    final TenkaBase64DS nSource;
    try {
      final BeizeProgramConstant program = await TenkaCompiler.compile(
        config.source as TenkaLocalFileDS,
      );
      final List<dynamic> serialized = program.serialize();
      final String jsonified = json.encode(serialized);
      nSource = TenkaBase64DS(Uint8List.fromList(utf8.encode(jsonified)));
    } catch (err) {
      throw Exception('Failed to compile module: ${x.id()}\n$err');
    }

    final String distSourceBasename = '${config.id}.s.dat';
    final String distSourcePath = p.join(Paths.distDataDir, distSourceBasename);
    final String distSourceSubPath =
        p.relative(distSourcePath, from: Paths.distDir);
    await nSource.toLocalFile(
      TenkaLocalFileDSConverter.converter.fromFullPath(distSourcePath),
    );

    final TenkaBase64DS nThumbnail = await TenkaBase64DSConverter.converter
        .fromLocalFile(config.thumbnail as TenkaLocalFileDS);
    final String distThumbnailBasename = '${config.id}.png';
    final String distThumbnailPath =
        p.join(Paths.distDataDir, distThumbnailBasename);
    final String distThumbnailSubPath =
        p.relative(distThumbnailPath, from: Paths.distDir);
    await nThumbnail.toLocalFile(
      TenkaLocalFileDSConverter.converter.fromFullPath(distThumbnailPath),
    );

    final String nSha = sha256.convert(nSource.data).toString();
    final TenkaVersion nVersion = generatedConfig != null
        ? TenkaVersion.parse(generatedConfig.version)
        : TenkaVersion(now.year, now.month, 0);
    if (generatedConfig != null && generatedConfig.sha != nSha) {
      nVersion.increment();
    }
    final SGeneratedConfig nGeneratedConfig = SGeneratedConfig(
      version: nVersion.toString(),
      sha: nSha,
    );
    final File generatedConfigFile = File(
      p.join(x.dir(), SBaseModule.generatedConfigFileBasename),
    );
    await generatedConfigFile
        .writeAsString(json.encode(nGeneratedConfig.toJson()));

    final TenkaMetadata nMetadata = TenkaMetadata(
      id: config.id,
      name: config.name,
      type: config.type,
      author: config.author,
      source: TenkaCloudDS(distSourceSubPath),
      thumbnail: TenkaCloudDS(distThumbnailSubPath),
      nsfw: config.nsfw,
      version: nVersion,
      deprecated: config.deprecated,
    );
    modules[nMetadata.id] = nMetadata;
  }
}

Future<void> main() async {
  final SBuilder builder = SBuilder();
  await builder.initialize();
  await builder.build();
  await builder.dispose();
}
