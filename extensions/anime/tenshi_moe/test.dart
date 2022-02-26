import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';

import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await MockedAnimeExtractor(
    MockedAnimeExtractorOptions(
      search: (final AnimeExtractor ext) => ext.search(
        'mayo chiki',
        locale,
      ),
      getInfo: (final AnimeExtractor ext) => ext.getInfo(
        'https://tenshi.moe/anime/1kwzf88a',
        locale,
      ),
      getSources: (final AnimeExtractor ext) => ext.getSources(
        const EpisodeInfo(
          episode: '1',
          url: 'https://tenshi.moe/anime/1kwzf88a/1',
          locale: locale,
        ),
      ),
      handleEnvironment: GlobalState.handleIndividualTestEnvironment,
    ),
  ).run(Utils.getAnimeDS('tenshi_moe'));
}
