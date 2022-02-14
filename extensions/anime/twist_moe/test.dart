import 'package:extensions/extensions.dart';
import 'package:extensions_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';

import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await TAnimeExtractor(
    TAnimeExtractorOptions(
      search: (final AnimeExtractor ext) => ext.search(
        'bunny girl',
        locale,
      ),
      getInfo: (final AnimeExtractor ext) => ext.getInfo(
        'https://twist.moe/a/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
        locale,
      ),
      getSources: (final AnimeExtractor ext) => ext.getSources(
        const EpisodeInfo(
          episode: '1',
          url:
              'https://twist.moe/a/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai/1',
          locale: locale,
        ),
      ),
    ),
  ).run(Utils.getAnimeDS('twist_moe'));
}
