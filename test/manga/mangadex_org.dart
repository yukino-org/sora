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
      'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/',
      'en',
    ),
    getChapter: (ext) async => ext.getChapter(
      ChapterInfo(
        chapter: '1',
        url:
            'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/1.html',
        locale: 'en',
      ),
    ),
    getPage: (ext) async => ext.getPage(
      PageInfo(
        url:
            'https://m.fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/31.html',
        locale: 'en',
      ),
    ),
  );
}
