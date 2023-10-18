import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../../../store/core/module.dart';

class ReadM extends SMangaModule {
  @override
  String id() => 'readm_org';

  @override
  String name() => 'ReadM';

  @override
  bool nsfw() => false;

  @override
  MockedMangaExtractor mock() {
    final MockedMangaExtractor mocked = MockedMangaExtractor(
      search: (final MangaExtractor ext) => ext.search(
        'tonikaku cawaii',
        ext.defaultLocale,
      ),
      getInfo: (final MangaExtractor ext) => ext.getInfo(
        'https://readm.org/manga/16381',
        ext.defaultLocale,
      ),
      getChapter: (final MangaExtractor ext) => ext.getChapter(
        'https://readm.org/manga/16381/1/all-pages',
        ext.defaultLocale,
      ),
      getPage: (final MangaExtractor ext) => ext.getPage(
        'https://readm.org/uploads/chapter_files/16381/6/1.jpg',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
