import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../../../store/core/module.dart';

class MangaSee123 extends $MangaModule {
  @override
  String id() => 'mangasee123_com';

  @override
  String name() => 'MangaSee';

  @override
  bool nsfw() => false;

  @override
  MockedMangaExtractor mock() {
    final MockedMangaExtractor mocked = MockedMangaExtractor(
      search: (final MangaExtractor ext) => ext.search(
        'spy x family',
        ext.defaultLocale,
      ),
      getInfo: (final MangaExtractor ext) => ext.getInfo(
        'https://mangasee123.com/manga/Spy-X-Family',
        ext.defaultLocale,
      ),
      getChapter: (final MangaExtractor ext) => ext.getChapter(
        'https://mangasee123.com/read-online/Spy-X-Family-chapter-62.5-page-1.html',
        ext.defaultLocale,
      ),
      getPage: (final MangaExtractor ext) => ext.getPage(
        'https://scans-hot.leanbox.us/manga/Spy-X-Family/0062.5-001.png',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
