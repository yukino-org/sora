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
    required this.ref,
  });

  final String version;
  final String ref;

  JsonMap toJson() => <dynamic, dynamic>{
        r'$note': 'This is a generated file, do not edit this.',
        'version': version,
        'ref': ref,
      };

  static Future<SGeneratedConfig> fromFile(final String path) async {
    final String content = await File(path).readAsString();
    final JsonMap json = jsonDecode(content) as JsonMap;
    return SGeneratedConfig(
      version: json['version'] as String,
      ref: json['ref'] as String,
    );
  }
}

abstract class SBaseModule<T> {
  String id();
  String name();
  bool nsfw();
  Future<TenkaMetadata> config();
  T mock();
}

abstract class SAnimeModule extends SBaseModule<MockedAnimeExtractor> {
  @override
  Future<TenkaMetadata> config() async {
    final String dir = Paths.getAnimeModuleDir(id());
    final SGeneratedConfig generatedConfig =
        await SGeneratedConfig.fromFile(p.join(dir, '_data.json'));
    final TenkaMetadata metadata = TenkaMetadata(
      id: id(),
      name: name(),
      type: TenkaType.anime,
      author: 'yukino-org',
      source: TenkaLocalFileDS(root: p.join(dir, 'src'), file: 'main.beize'),
      thumbnail: TenkaLocalFileDS(root: dir, file: 'icon.png'),
      nsfw: nsfw(),
      version: TenkaVersion.parse(generatedConfig.version),
      deprecated: false,
    );
    return metadata;
  }
}

abstract class SMangaModule extends SBaseModule<MockedMangaExtractor> {
  @override
  Future<TenkaMetadata> config() async {
    final String dir = Paths.getAnimeModuleDir(id());
    final SGeneratedConfig generatedConfig =
        await SGeneratedConfig.fromFile(p.join(dir, '_data.json'));
    final TenkaMetadata metadata = TenkaMetadata(
      id: id(),
      name: name(),
      type: TenkaType.manga,
      author: 'yukino-org',
      source: TenkaLocalFileDS(root: p.join(dir, 'src'), file: 'main.beize'),
      thumbnail: TenkaLocalFileDS(root: dir, file: 'icon.png'),
      nsfw: nsfw(),
      version: TenkaVersion.parse(generatedConfig.version),
      deprecated: false,
    );
    return metadata;
  }
}
