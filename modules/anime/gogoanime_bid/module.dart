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
        'https://anitaku.to/category/kage-no-jitsuryokusha-ni-naritakute-2nd-season',
        ext.defaultLocale,
      ),
      getSource: (final AnimeExtractor ext) => ext.getSource(
        'https://anitaku.to/kage-no-jitsuryokusha-ni-naritakute-2nd-season-episode-9',
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
