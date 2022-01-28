import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'Tenshi.moe',
    () async {
      await TAnimeExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/anime/tenshi_moe/src',
        ),
        file: 'main.ht',
        search: (final TAnimeExtractor ext) => ext.search(
          'mayo chiki',
          locale,
        ),
        getInfo: (final TAnimeExtractor ext) => ext.getInfo(
          'https://tenshi.moe/anime/1kwzf88a',
          locale,
        ),
        getSources: (final TAnimeExtractor ext) => ext.getSources(
          const EpisodeInfo(
            episode: '1',
            url: 'https://tenshi.moe/anime/1kwzf88a/1',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
