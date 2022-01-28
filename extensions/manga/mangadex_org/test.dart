import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'MangaDex.org',
    () async {
      await TMangaExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/manga/mangadex_org/src',
        ),
        file: 'main.ht',
        search: (final TMangaExtractor ext) => ext.search(
          'bunny girl',
          locale,
        ),
        getInfo: (final TMangaExtractor ext) => ext.getInfo(
          'https://api.mangadex.org/manga/b15632d7-88d0-4233-9815-c01e75cabda8',
          locale,
        ),
        getChapter: (final TMangaExtractor ext) => ext.getChapter(
          const ChapterInfo(
            volume: '2',
            chapter: '21',
            url: 'id:21089a43-60f3-4b75-abaa-17596f321ba1',
            locale: locale,
          ),
        ),
        getPage: (final TMangaExtractor ext) => ext.getPage(
          const PageInfo(
            url:
                'https://uploads.mangadex.org/data/c67bf16d31edf36be6b321b44b7dd41a/S19-2ca73f816c6ce0ed93b7e63126798856f970f58f6693eaf1a9458687732503a8.png',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
