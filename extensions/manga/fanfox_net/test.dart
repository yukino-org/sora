import 'package:extensions/extensions.dart';
import 'package:extensions_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';
import './config.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await config.test(
    TMangaExtractorOptions(
      search: (final MangaExtractor ext) => ext.search(
        'bunny girl',
        locale,
      ),
      getInfo: (final MangaExtractor ext) => ext.getInfo(
        'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/',
        locale,
      ),
      getChapter: (final MangaExtractor ext) => ext.getChapter(
        const ChapterInfo(
          chapter: '1',
          url:
              'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/1.html',
          locale: locale,
        ),
      ),
      getPage: (final MangaExtractor ext) => ext.getPage(
        const PageInfo(
          url:
              'https://m.fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/31.html',
          locale: locale,
        ),
      ),
    ),
  );
}
