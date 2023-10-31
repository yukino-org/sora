import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../../../store/core/module.dart';

class FanFox extends $MangaModule {
  @override
  String id() => 'fanfox_net';

  @override
  String name() => 'FanFox';

  @override
  bool nsfw() => false;

  @override
  MockedMangaExtractor mock() {
    final MockedMangaExtractor mocked = MockedMangaExtractor(
      search: (final MangaExtractor ext) => ext.search(
        'bunny girl',
        ext.defaultLocale,
      ),
      getInfo: (final MangaExtractor ext) => ext.getInfo(
        'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/',
        ext.defaultLocale,
      ),
      getChapter: (final MangaExtractor ext) => ext.getChapter(
        'https://fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/1.html',
        ext.defaultLocale,
      ),
      getPage: (final MangaExtractor ext) => ext.getPage(
        'https://m.fanfox.net/manga/seishun_buta_yarou_wa_bunny_girl_senpai_no_yume_o_minai/c001/31.html',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
