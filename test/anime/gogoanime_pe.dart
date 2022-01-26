import 'dart:io';
import 'package:extensions_test/test.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await AnimeExtractorTest.testFile(
    path.join(
      Directory.current.path,
      'extensions/anime/gogoanime_pe/gogoanime_pe.ht',
    ),
    search: (final AnimeExtractorTest ext) => ext.search(
      'bunny girl',
      TestEnvironmentManager.defaultLocale,
    ),
    getInfo: (final AnimeExtractorTest ext) => ext.getInfo(
      'https://gogoanime.pe/category/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
      TestEnvironmentManager.defaultLocale,
    ),
    getSources: (final AnimeExtractorTest ext) => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url:
            'https://gogoanime.pe//seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai-episode-1',
        locale: TestEnvironmentManager.defaultLocale,
      ),
    ),
  );
}
