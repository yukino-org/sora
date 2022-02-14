import 'package:extensions/extensions.dart';
import 'package:extensions_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';

import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await TAnimeExtractor(
    TAnimeExtractorOptions(
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
    ),
  ).run(Utils.getAnimeDS('gogoanime_pe'));
}
