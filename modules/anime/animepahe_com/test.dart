import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('animepahe_com');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search(
    'bunny girl',
    locale,
  ),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://animepahe.com/anime/377e86f7-3052-e675-020d-bc7e3e076c0d',
    locale,
  ),
  getSources: (final AnimeExtractor ext) => ext.getSources(
    'https://animepahe.com/anime/377e86f7-3052-e675-020d-bc7e3e076c0d?id=2807&episode=13',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
