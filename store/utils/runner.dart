import 'package:utilx/utils.dart';

abstract class Runner {
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
}
