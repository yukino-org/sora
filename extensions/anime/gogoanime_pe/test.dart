import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';

import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await MockedAnimeExtractor(
    MockedAnimeExtractorOptions(
      search: (final AnimeExtractor ext) => ext.search('bunny girl', locale),
      getInfo: (final AnimeExtractor ext) => ext.getInfo(
        'https://gogoanime.pe/category/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
        locale,
      ),
      getSources: (final AnimeExtractor ext) => ext.getSources(
        const EpisodeInfo(
          episode: '1',
          url:
              'https://gogoanime.pe//seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai-episode-1',
          locale: locale,
        ),
      ),
      handleEnvironment: GlobalState.handleIndividualTestEnvironment,
    ),
  ).run(Utils.getAnimeDS('gogoanime_pe'));
}
