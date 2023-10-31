import 'package:sora_builder/sora_builder.dart';
import 'paths.dart';
import 'urls.dart';

abstract class $AnimeModule extends SoraAnimeModule {
  @override
  String author() => $urls.ghUsername;

  @override
  SoraPaths paths() => $paths;
}

abstract class $MangaModule extends SoraMangaModule {
  @override
  String author() => $urls.ghUsername;

  @override
  SoraPaths paths() => $paths;
}
