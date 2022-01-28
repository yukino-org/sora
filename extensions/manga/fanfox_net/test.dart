import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:utilx/utilities/locale.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  test(
    'FanFox.net',
    () async {
      await TMangaExtractor.testFile(
        root: path.join(
          Directory.current.path,
          'extensions/manga/fanfox_net/src',
        ),
        file: 'main.ht',
        search: (final TMangaExtractor ext) => ext.search(
          'bunny girl',
          locale,
        ),
        getInfo: (final TMangaExtractor ext) => ext.getInfo(
          'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/',
          locale,
        ),
        getChapter: (final TMangaExtractor ext) => ext.getChapter(
          const ChapterInfo(
            chapter: '1',
            url:
                'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/1.html',
            locale: locale,
          ),
        ),
        getPage: (final TMangaExtractor ext) => ext.getPage(
          const PageInfo(
            url:
                'https://m.fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/31.html',
            locale: locale,
          ),
        ),
      );
    },
    timeout: Timeout.none,
  );
}
