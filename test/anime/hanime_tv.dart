import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await AnimeExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/anime/hanime_tv/hanime_tv.ht',
    ),
    search: (final AnimeExtractorTest ext) => ext.search(
      'overflow',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final AnimeExtractorTest ext) => ext.getInfo(
      'https://hanime.tv/videos/hentai/overflow-season-1',
      TestEnvironmentManager.defaultLocale,
    ),
    getSources: (final AnimeExtractorTest ext) => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url: 'https://hanime.tv/videos/hentai/overflow-season-1',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
