import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await MangaExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/manga/readm_org/readm_org.ht',
    ),
    search: (final MangaExtractorTest ext) => ext.search(
      'tonikaku cawaii',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final MangaExtractorTest ext) => ext.getInfo(
      'https://readm.org/manga/16381',
      TestEnvironmentManager.defaultLocale,
    ),
    getChapter: (final MangaExtractorTest ext) => ext.getChapter(
      const ChapterInfo(
        chapter: '1',
        url: 'https://readm.org/manga/16381/1/all-pages',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
    getPage: (final MangaExtractorTest ext) => ext.getPage(
      const PageInfo(
        url: 'https://readm.org/uploads/chapter_files/16381/6/1.jpg',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
