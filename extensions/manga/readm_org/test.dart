import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'ReadM.org',
    () async {
      await TMangaExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/manga/readm_org/src',
        ),
        file: 'main.ht',
        search: (final TMangaExtractor ext) => ext.search(
          'tonikaku cawaii',
          locale,
        ),
        getInfo: (final TMangaExtractor ext) => ext.getInfo(
          'https://readm.org/manga/16381',
          locale,
        ),
        getChapter: (final TMangaExtractor ext) => ext.getChapter(
          const ChapterInfo(
            chapter: '1',
            url: 'https://readm.org/manga/16381/1/all-pages',
            locale: locale,
          ),
        ),
        getPage: (final TMangaExtractor ext) => ext.getPage(
          const PageInfo(
            url: 'https://readm.org/uploads/chapter_files/16381/6/1.jpg',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
