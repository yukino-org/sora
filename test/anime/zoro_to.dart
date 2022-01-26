import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await AnimeExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/anime/zoro_to/zoro_to.ht',
    ),
    search: (final AnimeExtractorTest ext) => ext.search(
      'bunny girl',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final AnimeExtractorTest ext) => ext.getInfo(
      'https://zoro.to/rascal-does-not-dream-of-bunny-girl-senpai-149?ref=search',
      TestEnvironmentManager.defaultLocale,
    ),
    getSources: (final AnimeExtractorTest ext) => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url:
            'https://zoro.to/watch/rascal-does-not-dream-of-bunny-girl-senpai-149?ep=4008',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
