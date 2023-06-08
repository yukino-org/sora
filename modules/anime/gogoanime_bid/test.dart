import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('gogoanime_bid');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search('spy kyoushitsu', locale),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://www1.gogoanime.bid/category/spy-kyoushitsu',
    locale,
  ),
  getSource: (final AnimeExtractor ext) => ext.getSource(
    'https://www1.gogoanime.bid/spy-kyoushitsu-episode-1',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
