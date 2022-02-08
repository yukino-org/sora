import 'dart:io';
import 'package:extensions/metadata.dart';
import 'package:extensions_dev_tools/tools.dart';
import 'package:path/path.dart' as path;

final String _dirname =
    path.join(Directory.current.path, 'extensions/manga/mangadex_org');

final EConfig config = EConfig(
  EMetadata(
    name: 'MangaDex.org',
    type: EType.manga,
    source: ELocalFileDS(
      root: path.join(_dirname, 'src'),
      file: 'main.ht',
    ),
    thumbnail: ELocalFileDS(root: _dirname, file: 'logo.png'),
    nsfw: false,
  ),
);
