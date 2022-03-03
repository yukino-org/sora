import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getMangaDS('readm_org');
final MockedMangaExtractor mocked = MockedMangaExtractor(
  search: (final MangaExtractor ext) => ext.search(
    'tonikaku cawaii',
    locale,
  ),
  getInfo: (final MangaExtractor ext) => ext.getInfo(
    'https://readm.org/manga/16381',
    locale,
  ),
  getChapter: (final MangaExtractor ext) => ext.getChapter(
    'https://readm.org/manga/16381/1/all-pages',
    locale,
  ),
  getPage: (final MangaExtractor ext) => ext.getPage(
    'https://readm.org/uploads/chapter_files/16381/6/1.jpg',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
