import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await MangaExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/manga/mangadex_org/mangadex_org.ht',
    ),
    search: (final MangaExtractorTest ext) => ext.search(
      'bunny girl',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final MangaExtractorTest ext) => ext.getInfo(
      'https://api.mangadex.org/manga/b15632d7-88d0-4233-9815-c01e75cabda8',
      TestEnvironmentManager.defaultLocale,
    ),
    getChapter: (final MangaExtractorTest ext) => ext.getChapter(
      const ChapterInfo(
        volume: '2',
        chapter: '21',
        url: 'id:21089a43-60f3-4b75-abaa-17596f321ba1',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
    getPage: (final MangaExtractorTest ext) => ext.getPage(
      const PageInfo(
        url:
            'https://uploads.mangadex.org/data/c67bf16d31edf36be6b321b44b7dd41a/S19-2ca73f816c6ce0ed93b7e63126798856f970f58f6693eaf1a9458687732503a8.png',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
