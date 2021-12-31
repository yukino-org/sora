import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:path/path.dart' as path;
import './test.dart';

Future<void> main() async {
  await run(
    path.join(
      Directory.current.path,
      'extensions/anime/gogoanime_pe/gogoanime_pe.ht',
    ),
    search: (ext) async => ext.search('bunny girl', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://gogoanime.pe/category/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
      'en',
    ),
    getSources: (ext) async => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url:
            'https://gogoanime.pe//seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai-episode-1',
        locale: defaultLocale,
      ),
    ),
  );
}
