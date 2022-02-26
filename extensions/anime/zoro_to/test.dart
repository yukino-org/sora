import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utilities/locale.dart';
import '../../utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('zoro_to');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search(
    'bunny girl',
    locale,
  ),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://zoro.to/rascal-does-not-dream-of-bunny-girl-senpai-149?ref=search',
    locale,
  ),
  getSources: (final AnimeExtractor ext) => ext.getSources(
    const EpisodeInfo(
      episode: '1',
      url:
          'https://zoro.to/watch/rascal-does-not-dream-of-bunny-girl-senpai-149?ep=4008',
      locale: locale,
    ),
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
