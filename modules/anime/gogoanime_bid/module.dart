import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/test/anime.dart';
import '../../../store/core/module.dart';

class GogoAnime extends $AnimeModule {
  @override
  String id() => 'gogoanime_bid';

  @override
  String name() => 'GogoAnime';

  @override
  bool nsfw() => false;

  @override
  MockedAnimeExtractor mock() {
    final MockedAnimeExtractor mocked = MockedAnimeExtractor(
      search: (final AnimeExtractor ext) => ext.search(
        'spy kyoushitsu',
        ext.defaultLocale,
      ),
      getInfo: (final AnimeExtractor ext) => ext.getInfo(
        'https://www1.gogoanime.bid/category/spy-kyoushitsu',
        ext.defaultLocale,
      ),
      getSource: (final AnimeExtractor ext) => ext.getSource(
        'https://www1.gogoanime.bid/spy-kyoushitsu-episode-1',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
