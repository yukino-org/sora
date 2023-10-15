import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('zoro_to');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search(
    'bunny girl',
    locale,
  ),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://aniwatch.to/rascal-does-not-dream-of-bunny-girl-senpai-149?ref=search',
    locale,
  ),
  getSource: (final AnimeExtractor ext) => ext.getSource(
    'https://aniwatch.to/watch/rascal-does-not-dream-of-bunny-girl-senpai-149?ep=4008',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
