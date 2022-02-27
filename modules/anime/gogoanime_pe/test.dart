import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('gogoanime_pe');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search('bunny girl', locale),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://gogoanime.fi/category/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
    locale,
  ),
  getSources: (final AnimeExtractor ext) => ext.getSources(
    const EpisodeInfo(
      episode: '1',
      url:
          'https://gogoanime.fi/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai-episode-1',
      locale: locale,
    ),
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
