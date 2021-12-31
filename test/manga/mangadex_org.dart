import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:path/path.dart' as path;
import './test.dart';

Future<void> main() async {
  await run(
    path.join(
      Directory.current.path,
      'extensions/manga/mangadex_org/mangadex_org.ht',
    ),
    search: (ext) async => ext.search('bunny girl', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://api.mangadex.org/manga/b15632d7-88d0-4233-9815-c01e75cabda8',
      'en',
    ),
    getChapter: (ext) async => ext.getChapter(
      const ChapterInfo(
        volume: '2',
        chapter: '21',
        url: '{&server_url&}/data/c67bf16d31edf36be6b321b44b7dd41a',
        locale: defaultLocale,
      ),
    ),
    getPage: (ext) async => ext.getPage(
      const PageInfo(
        url:
            'https://uploads.mangadex.org/data/c67bf16d31edf36be6b321b44b7dd41a/S19-2ca73f816c6ce0ed93b7e63126798856f970f58f6693eaf1a9458687732503a8.png',
        locale: defaultLocale,
      ),
    ),
  );
}
