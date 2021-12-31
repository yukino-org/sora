import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:path/path.dart' as path;
import './test.dart';

Future<void> main() async {
  await run(
    path.join(
      Directory.current.path,
      'extensions/manga/readm_org/readm_org.ht',
    ),
    search: (ext) async => ext.search('tonikaku cawaii', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://readm.org/manga/16381',
      'en',
    ),
    getChapter: (ext) async => ext.getChapter(
      const ChapterInfo(
        chapter: '1',
        url: 'https://readm.org/manga/16381/1/all-pages',
        locale: defaultLocale,
      ),
    ),
    getPage: (ext) async => ext.getPage(
      const PageInfo(
        url: 'https://readm.org/uploads/chapter_files/16381/6/1.jpg',
        locale: defaultLocale,
      ),
    ),
  );
}
