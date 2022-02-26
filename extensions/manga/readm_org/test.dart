import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await MockedMangaExtractor(
    MockedMangaExtractorOptions(
      search: (final MangaExtractor ext) => ext.search(
        'tonikaku cawaii',
        locale,
      ),
      getInfo: (final MangaExtractor ext) => ext.getInfo(
        'https://readm.org/manga/16381',
        locale,
      ),
      getChapter: (final MangaExtractor ext) => ext.getChapter(
        const ChapterInfo(
          chapter: '1',
          url: 'https://readm.org/manga/16381/1/all-pages',
          locale: locale,
        ),
      ),
      getPage: (final MangaExtractor ext) => ext.getPage(
        const PageInfo(
          url: 'https://readm.org/uploads/chapter_files/16381/6/1.jpg',
          locale: locale,
        ),
      ),
      handleEnvironment: GlobalState.handleIndividualTestEnvironment,
    ),
  ).run(Utils.getMangaDS('readm_org'));
}
