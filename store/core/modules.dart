import 'package:sora_builder/sora_builder.dart';
import 'modules_exports.dart';

final SoraModules $modules = SoraModules(
  anime: <SoraAnimeModule>[
    AnimePahe(),
    GogoAnime(),
    HAnime(),
  ],
  manga: <SoraMangaModule>[
    FanFox(),
    MangaDex(),
    MangaSee123(),
  ],
);
