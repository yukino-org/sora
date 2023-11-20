import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/test/anime.dart';
import '../../../store/core/module.dart';

class AnimePahe extends $AnimeModule {
  @override
  String id() => 'animepahe_com';

  @override
  String name() => 'AnimePahe';

  @override
  bool nsfw() => false;

  @override
  MockedAnimeExtractor mock() {
    late final String animeUrl;
    late final String episodeUrl;

    final MockedAnimeExtractor mocked = MockedAnimeExtractor(
      search: (final AnimeExtractor ext) async {
        final List<SearchInfo> results = await ext.search(
          'bunny girl',
          ext.defaultLocale,
        );
        animeUrl = results.first.url;
        return results;
      },
      getInfo: (final AnimeExtractor ext) async {
        final AnimeInfo result = await ext.getInfo(
          animeUrl,
          ext.defaultLocale,
        );
        episodeUrl = result.episodes.first.url;
        return result;
      },
      getSource: (final AnimeExtractor ext) => ext.getSource(
        episodeUrl,
        ext.defaultLocale,
      ),
    );
    return mocked;
  }
}
