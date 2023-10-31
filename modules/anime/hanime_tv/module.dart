import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/test/anime.dart';
import '../../../store/core/module.dart';

class HAnime extends $AnimeModule {
  @override
  String id() => 'hanime_tv';

  @override
  String name() => 'hanime';

  @override
  bool nsfw() => true;

  @override
  MockedAnimeExtractor mock() {
    final MockedAnimeExtractor mocked = MockedAnimeExtractor(
      search: (final AnimeExtractor ext) => ext.search(
        'overflow',
        ext.defaultLocale,
      ),
      getInfo: (final AnimeExtractor ext) => ext.getInfo(
        'https://hanime.tv/videos/hentai/overflow-season-1',
        ext.defaultLocale,
      ),
      getSource: (final AnimeExtractor ext) => ext.getSource(
        'https://hanime.tv/videos/hentai/overflow-season-1#__episode=1',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
