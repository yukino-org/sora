import 'dart:io';
import 'package:extensions/metadata.dart';
import 'package:path/path.dart' as path;

abstract class Utils {
  static const String mainScriptFile = 'main.ht';

  static final String animeDir =
      path.join(Directory.current.path, 'extensions/anime');

  static final String mangaDir =
      path.join(Directory.current.path, 'extensions/manga');

  static ELocalFileDS getAnimeDS(final String dir) => ELocalFileDS(
        root: path.join(animeDir, '$dir/src'),
        file: mainScriptFile,
      );

  static ELocalFileDS getMangaDS(final String dir) => ELocalFileDS(
        root: path.join(mangaDir, '$dir/src'),
        file: mainScriptFile,
      );

  static String prettyPath(final String p) =>
      path.normalize(p).replaceAll(RegExp(r'[\\/]'), '/');
}
