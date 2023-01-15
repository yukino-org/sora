import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:tenka/tenka.dart';
import 'package:utilx/utils.dart';

export 'procedure.dart';

abstract class Emojis {
  static const String tick = '✔️';
  static const String cross = '❌';

  // ignore: avoid_positional_boolean_parameters
  static String fromBool(final bool value) => value ? tick : cross;
}

abstract class Utils {
  static const String mainScriptFile = 'main.fbs';

  static final String baseDir = path.dirname(Directory.current.path);

  static final String animeDir =
      path.join(Directory.current.path, 'modules/anime');

  static final String mangaDir =
      path.join(Directory.current.path, 'modules/manga');

  static final String summaryOutput =
      path.join(Directory.current.path, 'dist/summary/README.md');

  static const String ghUserName = 'yukino-org';
  static const String ghRepoName = 'tenka-modules';
  static const String ghMainBranch = 'main';

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
    final List<Future<T> Function()> fns, {
    final int concurrent = -1,
  }) async {
    final List<List<Future<T> Function()>> chunks = concurrent > 0
        ? ListUtils.chunk(fns, concurrent)
        : <List<Future<T> Function()>>[fns];

    final List<List<T>> results = await sequencial(
      chunks
          .map(
            (final List<Future<T> Function()> x) =>
                () => Future.wait(x.map((final Future<T> Function() y) => y())),
          )
          .toList(),
    );

    return results.fold<List<T>>(
      <T>[],
      (final List<T> value, final List<T> x) => value..addAll(x),
    );
  }

  static String get ghMainBranchURL =>
      'https://github.com/$ghUserName/$ghRepoName/tree/$ghMainBranch';
}
