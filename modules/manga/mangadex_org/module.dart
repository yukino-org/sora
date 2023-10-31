import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../../../store/core/module.dart';

class MangaDex extends $MangaModule {
  @override
  String id() => 'mangadex_org';

  @override
  String name() => 'MangaDex';

  @override
  bool nsfw() => false;

  @override
  MockedMangaExtractor mock() {
    final MockedMangaExtractor mocked = MockedMangaExtractor(
      search: (final MangaExtractor ext) => ext.search(
        'masamune kun revenge',
        ext.defaultLocale,
      ),
      getInfo: (final MangaExtractor ext) => ext.getInfo(
        'https://api.mangadex.org/manga/7bee0d50-f466-4fa1-8338-7c804be45187',
        ext.defaultLocale,
      ),
      getChapter: (final MangaExtractor ext) => ext.getChapter(
        'id:21089a43-60f3-4b75-abaa-17596f321ba1',
        ext.defaultLocale,
      ),
      getPage: (final MangaExtractor ext) => ext.getPage(
        'https://uploads.mangadex.org/data/c67bf16d31edf36be6b321b44b7dd41a/S19-2ca73f816c6ce0ed93b7e63126798856f970f58f6693eaf1a9458687732503a8.png',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
