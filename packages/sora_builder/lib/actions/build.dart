import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utils.dart';
import '../core/exports.dart';

class SoraBuilder {
  SoraBuilder({
    required this.modules,
    required this.paths,
    required this.urls,
  });

  final SoraModules modules;
  final SoraPaths paths;
  final SoraUrls urls;
  final DateTime now = DateTime.now();

  Future<void> initialize() async {
    await TenkaDevEnvironment.prepare();
  }

  Future<void> build() async {
    await FSUtils.recreateDirectory(Directory(paths.storeOutputDir));
    await FSUtils.recreateDirectory(Directory(paths.storeOutputDataDir));

    final TenkaStore store = TenkaStore(
      baseURL: urls.storeBaseUrl(),
      modules: <String, TenkaMetadata>{},
      builtAt: now,
    );
    for (final SoraBaseModule<dynamic> x in <SoraBaseModule<dynamic>>[
      ...modules.anime,
      ...modules.manga,
    ]) {
      await _loadMetadata(store, x);
    }

    final String storeJson = json.encode(store.toJson());
    final File storeFile = File(paths.storeOutputJsonPath);
    await storeFile.writeAsString(storeJson);

    final String storeChecksum = sha256.convert(storeJson.codeUnits).toString();
    final File storeChecksumFile = File(paths.storeOutputChecksumPath);
    await storeChecksumFile.writeAsString(storeChecksum);
  }

  Future<void> dispose() async {
    await TenkaDevEnvironment.dispose();
  }

  Future<void> _loadMetadata(
    final TenkaStore store,
    final SoraBaseModule<dynamic> x,
  ) async {
    final SoraGeneratedConfig? generatedConfig = await x.generatedConfig();
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
    final String distSourcePath =
        p.join(paths.storeOutputDataDir, distSourceBasename);
    final String distSourceSubPath =
        p.relative(distSourcePath, from: paths.storeOutputDir);
    await nSource.toLocalFile(
      TenkaLocalFileDSConverter.converter.fromFullPath(distSourcePath),
    );

    final TenkaBase64DS nThumbnail = await TenkaBase64DSConverter.converter
        .fromLocalFile(config.thumbnail as TenkaLocalFileDS);
    final String distThumbnailBasename = '${config.id}.png';
    final String distThumbnailPath =
        p.join(paths.storeOutputDataDir, distThumbnailBasename);
    final String distThumbnailSubPath =
        p.relative(distThumbnailPath, from: paths.storeOutputDir);
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
    final SoraGeneratedConfig nGeneratedConfig = SoraGeneratedConfig(
      version: nVersion.toString(),
      sha: nSha,
    );
    final File generatedConfigFile =
        File(paths.getGeneratedConfigPath(x.dir()));
    await generatedConfigFile
        .writeAsString(json.encode(nGeneratedConfig.toJson()));

    final TenkaMetadata nMetadata = TenkaMetadata(
      id: config.id,
      name: config.name,
      type: config.type,
      author: config.author,
      source: TenkaCloudDS('/$distSourceSubPath'),
      thumbnail: TenkaCloudDS('/$distThumbnailSubPath'),
      nsfw: config.nsfw,
      version: nVersion,
      deprecated: config.deprecated,
    );
    store.modules[nMetadata.id] = nMetadata;
  }
}
