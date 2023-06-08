import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('hanime_tv');
final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) => ext.search('overflow', locale),
  getInfo: (final AnimeExtractor ext) => ext.getInfo(
    'https://hanime.tv/videos/hentai/overflow-season-1',
    locale,
  ),
  getSource: (final AnimeExtractor ext) => ext.getSource(
    'https://hanime.tv/videos/hentai/overflow-season-1#__episode=1',
    locale,
  ),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
