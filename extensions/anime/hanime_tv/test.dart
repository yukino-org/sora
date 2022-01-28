import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'HAnime.tv',
    () async {
      await TAnimeExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/anime/hanime_tv/src',
        ),
        file: 'main.ht',
        search: (final TAnimeExtractor ext) => ext.search('overflow', locale),
        getInfo: (final TAnimeExtractor ext) => ext.getInfo(
          'https://hanime.tv/videos/hentai/overflow-season-1',
          locale,
        ),
        getSources: (final TAnimeExtractor ext) => ext.getSources(
          const EpisodeInfo(
            episode: '1',
            url: 'https://hanime.tv/videos/hentai/overflow-season-1',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
