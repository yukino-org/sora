import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:tenka/tenka.dart';

enum GlobalStateMode {
  unknown,
  testAll,
}

abstract class GlobalState {
  static GlobalStateMode mode = GlobalStateMode.unknown;

  static bool get handleIndividualTestEnvironment =>
      mode != GlobalStateMode.testAll;
}

abstract class Utils {
  static const String mainScriptFile = 'main.ht';

  static final String animeDir =
      path.join(Directory.current.path, 'extensions/anime');

  static final String mangaDir =
      path.join(Directory.current.path, 'extensions/manga');

  static TenkaLocalFileDS getAnimeDS(final String dir) => TenkaLocalFileDS(
        root: path.join(animeDir, '$dir/src'),
        file: mainScriptFile,
      );

  static TenkaLocalFileDS getMangaDS(final String dir) => TenkaLocalFileDS(
        root: path.join(mangaDir, '$dir/src'),
        file: mainScriptFile,
      );

  static String prettyPath(final String p) =>
      path.normalize(p).replaceAll(RegExp(r'[\\/]'), '/');
}
