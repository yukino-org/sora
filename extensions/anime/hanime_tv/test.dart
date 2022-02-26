import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('hanime_tv');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
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
);

Future<void> main() async {
  await Procedure.run(() => MockedAnimeExtractorRunner(mocked).run(source));
}
