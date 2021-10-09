import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:path/path.dart' as path;
import './test.dart';

Future<void> main() async {
  await run(
    path.join(
      Directory.current.path,
      'extensions/anime/tenshi_moe/tenshi_moe.ht',
    ),
    search: (ext) async => ext.search('mayo chiki', 'en'),
    getInfo: (ext) async => ext.getInfo(
      'https://tenshi.moe/anime/1kwzf88a',
      'en',
    ),
    getSources: (ext) async => ext.getSources(
      EpisodeInfo(
        episode: '1',
        url: 'https://tenshi.moe/anime/1kwzf88a/1',
        locale: 'en',
      ),
    ),
  );
}
