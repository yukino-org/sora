import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:path/path.dart' as path;
import './test.dart';

Future<void> main() async {
  await run(
    path.join(
      Directory.current.path,
      'extensions/anime/twist_moe/twist_moe.ht',
    ),
    search: (ext) async => ext.search('bunny girl', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://twist.moe/a/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai',
      'en',
    ),
    getSources: (ext) async => ext.getSources(
      const EpisodeInfo(
        episode: '1',
        url:
            'https://twist.moe/a/seishun-buta-yarou-wa-bunny-girl-senpai-no-yume-wo-minai/1',
        locale: defaultLocale,
      ),
    ),
  );
}
