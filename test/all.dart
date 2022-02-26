// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../extensions/utils.dart';
import 'files.dart';

class TestAll {
  final Map<String, Map<String, bool>> results = <String, Map<String, bool>>{};

  Future<void> init() async {}

  Future<void> run(
    final TenkaLocalFileDS source,
    final Future<Map<String, bool>> Function() fn,
  ) async {
    final String k =
        '${Colorize(path.basename(path.dirname(source.root))).cyan()} ${Colorize('(${Utils.prettyPath(source.fullPath)})').darkGray()}';

    print('Testing: $k');
    results[source.fullPath] = await fn();
    print('Tested: $k\n');
  }

  Future<void> finish() async {
    exitCode = failed == 0 ? 0 : 1;

    print(
      'Full Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
    );

    for (final MapEntry<String, Map<String, bool>> x in results.entries) {
      print(
        ' ${Colorize('*').darkGray()} ${Colorize(path.basename(path.dirname(path.dirname(x.key)))).cyan()} (${Colorize(Utils.prettyPath(x.key)).darkGray()})',
      );

      for (final MapEntry<String, bool> y in x.value.entries) {
        print(
          '    ${Colorize('*').darkGray()} ${Colorize('${y.key}()').cyan()}: ${y.value ? Colorize('P').green() : Colorize('F').red()}',
        );
      }
    }
  }

  int get passed => results.values.fold<int>(
        0,
        (final int value, final Map<String, bool> x) =>
            value + x.values.where((final bool x) => x).length,
      );

  int get failed => results.values.fold<int>(
        0,
        (final int value, final Map<String, bool> x) =>
            value + x.values.where((final bool x) => !x).length,
      );
}

Future<void> main() async {
  await Procedure.run(() async {
    final TestAll tester = TestAll();
    await tester.init();

    for (final MapEntry<TenkaLocalFileDS, MockedAnimeExtractor> x
        in TestFiles.anime.entries) {
      await tester.run(
        x.key,
        () => MockedAnimeExtractorRunner(
          x.value,
          handleEnvironment: false,
          setExitCode: false,
        ).run(x.key),
      );
    }

    for (final MapEntry<TenkaLocalFileDS, MockedMangaExtractor> x
        in TestFiles.manga.entries) {
      await tester.run(
        x.key,
        () => MockedMangaExtractorRunner(
          x.value,
          handleEnvironment: false,
          setExitCode: false,
        ).run(x.key),
      );
    }

    await tester.finish();
  });
}
