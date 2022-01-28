import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'Zoro.to',
    () async {
      await TAnimeExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/anime/zoro_to/src',
        ),
        file: 'main.ht',
        search: (final TAnimeExtractor ext) => ext.search(
          'bunny girl',
          locale,
        ),
        getInfo: (final TAnimeExtractor ext) => ext.getInfo(
          'https://zoro.to/rascal-does-not-dream-of-bunny-girl-senpai-149?ref=search',
          locale,
        ),
        getSources: (final TAnimeExtractor ext) => ext.getSources(
          const EpisodeInfo(
            episode: '1',
            url:
                'https://zoro.to/watch/rascal-does-not-dream-of-bunny-girl-senpai-149?ep=4008',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
