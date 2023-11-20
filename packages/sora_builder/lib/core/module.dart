import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'paths.dart';

abstract class SoraBaseModule<T> {
  String id();
  String name();
  String author();
  TenkaType type();
  bool nsfw();
  SoraPaths paths();
  String dir();

  Future<TenkaMetadata> config() async {
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
      hash: '',
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
