import './modules_exported.dart';
import 'module.dart';

abstract class SModules {
  static final List<SAnimeModule> anime = <SAnimeModule>[
    AnimePahe(),
    GogoAnime(),
    HAnime(),
  ];

  static final List<SMangaModule> manga = <SMangaModule>[
    FanFox(),
    MangaDex(),
    MangaSee123(),
  ];
}
