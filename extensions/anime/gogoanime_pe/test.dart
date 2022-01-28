import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'GogoAnime.pe',
    () async {
      await TAnimeExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/anime/gogoanime_pe/src',
        ),
        file: 'main.ht',
        search: (final TAnimeExtractor ext) => ext.search('bunny girl', locale),
        getInfo: (final TAnimeExtractor ext) => ext.getInfo(
          'https://gogoanime.pe/category/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
          locale,
        ),
        getSources: (final TAnimeExtractor ext) => ext.getSources(
          const EpisodeInfo(
            episode: '1',
            url:
                'https://gogoanime.pe//seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai-episode-1',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
