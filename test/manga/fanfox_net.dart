import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await MangaExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/manga/fanfox_net/fanfox_net.ht',
    ),
    search: (final MangaExtractorTest ext) => ext.search(
      'bunny girl',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final MangaExtractorTest ext) => ext.getInfo(
      'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/',
      TestEnvironmentManager.defaultLocale,
    ),
    getChapter: (final MangaExtractorTest ext) => ext.getChapter(
      const ChapterInfo(
        chapter: '1',
        url:
            'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/1.html',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
    getPage: (final MangaExtractorTest ext) => ext.getPage(
      const PageInfo(
        url:
            'https://m.fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/31.html',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
