import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getMangaDS('mangasee123_com');
final MockedMangaExtractor mocked = MockedMangaExtractor(
  search: (final MangaExtractor ext) => ext.search(
    'spy x family',
    locale,
  ),
  getInfo: (final MangaExtractor ext) => ext.getInfo(
    'https://mangasee123.com/manga/Spy-X-Family',
    locale,
  ),
  getChapter: (final MangaExtractor ext) => ext.getChapter(
    'https://mangasee123.com/read-online/Spy-X-Family-chapter-62.5-page-1.html',
    locale,
  ),
  getPage: (final MangaExtractor ext) => ext.getPage(
    'https://scans-hot.leanbox.us/manga/Spy-X-Family/0062.5-001.png',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
