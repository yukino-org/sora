import 'dart:convert';
import 'dart:io';
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utils.dart';
import 'paths.dart';

class SoraGeneratedConfig {
  const SoraGeneratedConfig({
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

  static Future<SoraGeneratedConfig?> fromFile(final String path) async {
    final File file = File(path);
    if (!(await file.exists())) {
      return null;
    }
    final String content = await File(path).readAsString();
    final JsonMap json = jsonDecode(content) as JsonMap;
    return SoraGeneratedConfig(
      version: json['version'] as String,
      sha: json['sha'] as String,
    );
  }
}

abstract class SoraBaseModule<T> {
  String id();
  String name();
  String author();
  TenkaType type();
  bool nsfw();
  SoraPaths paths();
  String dir();

  Future<SoraGeneratedConfig?> generatedConfig() async {
    final String generatedConfigPath = _paths.getGeneratedConfigPath(dir());
    return SoraGeneratedConfig.fromFile(generatedConfigPath);
  }

  Future<TenkaMetadata> config() async {
    final SoraGeneratedConfig? generated = await generatedConfig();
    final TenkaMetadata metadata = TenkaMetadata(
      id: id(),
      name: name(),
      type: type(),
      author: author(),
      source: TenkaLocalFileDSConverter.converter
          .fromFullPath(_paths.getModuleMainScriptFile(_dir)),
      thumbnail: TenkaLocalFileDSConverter.converter
          .fromFullPath(_paths.getModuleLogoFile(_dir)),
      nsfw: nsfw(),
      version: generated != null
          ? TenkaVersion.parse(generated.version)
          : TenkaVersion(0, 0, 0),
      deprecated: false,
    );
    return metadata;
  }

  T mock();

  // i'm sorry, i had to
  SoraPaths get _paths => paths();
  String get _dir => dir();
}

abstract class SoraAnimeModule extends SoraBaseModule<MockedAnimeExtractor> {
  @override
  TenkaType type() => TenkaType.anime;

  @override
  String dir() => _paths.getAnimeModuleDir(id());
}

abstract class SoraMangaModule extends SoraBaseModule<MockedMangaExtractor> {
  @override
  TenkaType type() => TenkaType.manga;

  @override
  String dir() => _paths.getMangaModuleDir(id());
}

class SoraModules {
  const SoraModules({
    required this.anime,
    required this.manga,
  });

  final List<SoraAnimeModule> anime;
  final List<SoraMangaModule> manga;
}
