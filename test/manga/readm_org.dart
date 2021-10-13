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
    search: (ext) async => ext.search('bunny girl', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://readm.org/manga/15976',
      'en',
    ),
    getChapter: (ext) async => ext.getChapter(
      ChapterInfo(
        chapter: '1',
        url: 'https://readm.org/manga/15976/1/all-pages',
        locale: 'en',
      ),
    ),
    getPage: (ext) async => ext.getPage(
      PageInfo(
        url: 'https://readm.org/uploads/chapter_files/15976/6/1.jpg',
        locale: 'en',
      ),
    ),
  );
}
