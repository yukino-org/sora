import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await AnimeExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/anime/kawaiifu_com/kawaiifu_com.ht',
    ),
    search: (final AnimeExtractorTest ext) => ext.search(
      'mayo chiki',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final AnimeExtractorTest ext) => ext.getInfo(
      'https://kawaiifu.com/season/summer-2011/mayo-chiki-uncensored-high-quality-hd.html',
      TestEnvironmentManager.defaultLocale,
    ),
    getSources: (final AnimeExtractorTest ext) => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url:
            'https://domdom.stream/anime/season/summer-2011/mayo-chiki-uc-high-quality-hd-episode',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
