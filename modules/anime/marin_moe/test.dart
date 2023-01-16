import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('marin_moe');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search(
    'rent a girlfriend',
    locale,
  ),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://marin.moe/anime/1gxhsife',
    locale,
  ),
  getSources: (final AnimeExtractor ext) => ext.getSources(
    'https://marin.moe/anime/1gxhsife/1',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
