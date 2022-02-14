import 'package:extensions/extensions.dart';
import 'package:extensions_dev_tools/tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);

Future<void> main() async {
  await TAnimeExtractor(
    TAnimeExtractorOptions(
      search: (final AnimeExtractor ext) => ext.search('overflow', locale),
      getInfo: (final AnimeExtractor ext) => ext.getInfo(
        'https://hanime.tv/videos/hentai/overflow-season-1',
        locale,
      ),
      getSources: (final AnimeExtractor ext) => ext.getSources(
        const EpisodeInfo(
          episode: '1',
          url: 'https://hanime.tv/videos/hentai/overflow-season-1',
          locale: locale,
        ),
      ),
    ),
  ).run(Utils.getAnimeDS('hanime_tv'));
}
