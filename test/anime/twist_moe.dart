import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await AnimeExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/anime/twist_moe/twist_moe.ht',
    ),
    search: (final AnimeExtractorTest ext) => ext.search(
      'bunny girl',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final AnimeExtractorTest ext) => ext.getInfo(
      'https://twist.moe/a/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
      TestEnvironmentManager.defaultLocale,
    ),
    getSources: (final AnimeExtractorTest ext) => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url:
            'https://twist.moe/a/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai/1',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
