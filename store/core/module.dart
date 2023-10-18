import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utils.dart';
import '../utils/paths.dart';

class SGeneratedConfig {
  const SGeneratedConfig({
    required this.version,
    required this.sha,
  });

  final String version;
  final String sha;

  JsonMap toJson() => <dynamic, dynamic>{
        r'$note': 'This is a generated file, do not edit this.',
        'version': version,
        'sha': sha,
      };

  static Future<SGeneratedConfig?> fromFile(final String path) async {
    final File file = File(path);
    if (!(await file.exists())) {
      return null;
    }
    final String content = await File(path).readAsString();
    final JsonMap json = jsonDecode(content) as JsonMap;
    return SGeneratedConfig(
      version: json['version'] as String,
      sha: json['sha'] as String,
    );
  }
}

abstract class SBaseModule<T> {
  String id();
  String name();
  bool nsfw();
  String dir();

  Future<SGeneratedConfig?> generatedConfig() async {
    final SGeneratedConfig? generatedConfig = await SGeneratedConfig.fromFile(
      p.join(dir(), generatedConfigFileBasename),
    );
    return generatedConfig;
  }

  Future<TenkaMetadata> config();
  T mock();

  static const String generatedConfigFileBasename = '_data.json';
  static const String srcDirBasename = 'src';
  static const String mainScriptFileBasename = 'main.beize';
  static const String iconFileBasename = 'logo.png';
}

abstract class SAnimeModule extends SBaseModule<MockedAnimeExtractor> {
  @override
  String dir() => Paths.getAnimeModuleDir(id());

  @override
  Future<TenkaMetadata> config() async {
    final String dir = this.dir();
    final SGeneratedConfig? generated = await generatedConfig();
    final TenkaMetadata metadata = TenkaMetadata(
      id: id(),
      name: name(),
      type: TenkaType.anime,
      author: 'yukino-org',
      source: TenkaLocalFileDS(
        root: p.join(dir, SBaseModule.srcDirBasename),
        file: SBaseModule.mainScriptFileBasename,
      ),
      thumbnail: TenkaLocalFileDS(
        root: dir,
        file: SBaseModule.iconFileBasename,
      ),
      nsfw: nsfw(),
      version: generated != null
          ? TenkaVersion.parse(generated.version)
          : TenkaVersion(0, 0, 0),
      deprecated: false,
    );
    return metadata;
  }
}

abstract class SMangaModule extends SBaseModule<MockedMangaExtractor> {
  @override
  String dir() => Paths.getMangaModuleDir(id());

  @override
  Future<TenkaMetadata> config() async {
    final String dir = this.dir();
    final SGeneratedConfig? generated = await generatedConfig();
    final TenkaMetadata metadata = TenkaMetadata(
      id: id(),
      name: name(),
      type: TenkaType.manga,
      author: 'yukino-org',
      source: TenkaLocalFileDS(
        root: p.join(dir, SBaseModule.srcDirBasename),
        file: SBaseModule.mainScriptFileBasename,
      ),
      thumbnail: TenkaLocalFileDS(
        root: dir,
        file: SBaseModule.iconFileBasename,
      ),
      nsfw: nsfw(),
      version: generated != null
          ? TenkaVersion.parse(generated.version)
          : TenkaVersion(0, 0, 0),
      deprecated: false,
    );
    return metadata;
  }
}
