import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:path/path.dart' as path;
import './test.dart';

Future<void> main() async {
  await run(
    path.join(
      Directory.current.path,
      'extensions/anime/kawaiifu_com/kawaiifu_com.ht',
    ),
    search: (ext) async => ext.search('mayo chiki', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://kawaiifu.com/season/summer-2011/mayo-chiki-uncensored-high-quality-hd.html',
      'en',
    ),
    getSources: (ext) async => ext.getSources(
      EpisodeInfo(
        episode: '1',
        url:
            'https://domdom.stream/anime/season/summer-2011/mayo-chiki-uc-high-quality-hd-episode',
        locale: 'en',
      ),
    ),
  );
}
