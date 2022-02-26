import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getMangaDS('fanfox_net');
final MockedMangaExtractor mocked = MockedMangaExtractor(
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
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
