import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:tenka/tenka.dart';

export 'procedure.dart';

abstract class Emojis {
  static const String tick = '✔️';
  static const String cross = '❌';

  // ignore: avoid_positional_boolean_parameters
  static String fromBool(final bool value) => value ? tick : cross;
}

abstract class Utils {
  static const String mainScriptFile = 'main.ht';

  static final String animeDir =
      path.join(Directory.current.path, 'extensions/anime');

  static final String mangaDir =
      path.join(Directory.current.path, 'extensions/manga');

  static final String summaryOutput =
      path.join(Directory.current.path, 'dist/checkup.md');

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

  static Future<List<T>> sequencial<T>(
    final List<Future<T> Function()> fns,
  ) async {
    final List<T> results = <T>[];
    for (final Future<T> Function() x in fns) {
      results.add(await x());
    }
    return results;
  }

  static Future<List<T>> parallel<T>(
    final List<Future<T> Function()> fns,
  ) async =>
      Future.wait(fns.map((final Future<T> Function() x) => x()));
}
