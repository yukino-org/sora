import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions/metadata.dart';
import 'package:extensions_dev_tools/tools.dart';
import 'package:path/path.dart' as path;
import '../../constants.dart';

final String _dirname =
    path.join(Directory.current.path, 'extensions/manga/mangadex_org');

final EConfig config = EConfig(
  EMetadata(
    name: 'MangaDex.org',
    author: author,
    type: ExtensionType.manga,
    source: ELocalFileDS(
      root: path.join(_dirname, 'src'),
      file: 'main.ht',
    ),
    thumbnail: ELocalFileDS(root: _dirname, file: 'logo.png'),
    nsfw: false,
  ),
);
