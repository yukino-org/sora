import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/locale.dart';
import '../../../tools/utils.dart';

const Locale locale = Locale(LanguageCodes.en);
final TenkaLocalFileDS source = Utils.getAnimeDS('animepahe_com');

abstract class MockedData {
  static late final String animeURL;
  static late final String episodeURL;
}

final MockedAnimeExtractor mocked = MockedAnimeExtractor(
  search: (final AnimeExtractor ext) async {
    final List<SearchInfo> results = await ext.search('bunny girl', locale);
    MockedData.animeURL = results.first.url;
    return results;
  },
  getInfo: (final AnimeExtractor ext) async {
    final AnimeInfo result = await ext.getInfo(MockedData.animeURL, locale);
    MockedData.episodeURL = result.episodes.first.url;
    return result;
  },
  getSources: (final AnimeExtractor ext) =>
      ext.getSources(MockedData.episodeURL, locale),
);

Future<void> main() async {
  await Procedure.run(() => mocked.run(source));
}
