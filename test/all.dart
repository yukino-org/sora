// ignore_for_file: avoid_print

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utilities/utils.dart';
import '../tools/utils.dart';
import 'files.dart';

class TestAll {
  TestAll({
    required this.verbose,
  });

  final bool verbose;

  final Map<String, Map<String, Benchmarks>> animeResults =
      <String, Map<String, Benchmarks>>{};

  final Map<String, Map<String, Benchmarks>> mangaResults =
      <String, Map<String, Benchmarks>>{};

  Future<void> init() async {}

  Future<void> run(
    final TenkaType type,
    final TenkaLocalFileDS source,
    final Future<Map<String, Benchmarks>> Function() fn,
  ) async {
    final String k =
        '${Colorize(path.basename(path.dirname(source.root))).cyan()} ${Colorize('(${Utils.prettyPath(source.fullPath)})').darkGray()}';

    print('Testing: $k');

    final Map<String, Benchmarks> result = await fn();
    switch (type) {
      case TenkaType.anime:
        animeResults[source.fullPath] = result;
        break;

      case TenkaType.manga:
        mangaResults[source.fullPath] = result;
        break;
    }

    print('Tested: $k');
    if (verbose) print(' ');
  }

  Future<void> finish() async {
    print(
      'Full Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
    );

    for (final MapEntry<String, Map<String, Benchmarks>> x in results.entries) {
      print(
        ' ${Colorize('*').darkGray()} ${Colorize(_getModuleNameFromPath(x.key)).cyan()} ${Colorize('(${Utils.prettyPath(x.key)})').darkGray()}',
      );

      for (final MapEntry<String, Benchmarks> y in x.value.entries) {
        print(
          '    ${Colorize('*').darkGray()} ${Colorize('${y.key}()').cyan()}: ${y.value.success ? Colorize('P').green() : Colorize('F').red()}',
        );
      }
    }

    final File summaryFile = File(Utils.summaryOutput);
    await FSUtils.ensureFile(summaryFile);
    await summaryFile.writeAsString(summary);
  }

  String _getModuleNameFromPath(final String fullPath) =>
      path.basename(path.dirname(path.dirname(fullPath)));

  String _getValueFromBenchmarks(final Benchmarks result) =>
      '${Emojis.fromBool(result.success)} (${result.time.elapsed}ms)';

  String _createMarkdownTable(
    final Map<String, String> cols,
    final List<Map<String, String>> data,
  ) {
    const String seperator = ' | ';
    const String line = '---';

    return '''
$seperator ${cols.values.join(seperator)} $seperator
$seperator ${List<String>.filled(cols.length, line).join(seperator)} $seperator
$seperator ${data.map((final Map<String, String> x) => cols.keys.map((final String y) => x[y]).join(seperator)).join('\n')} $seperator
'''
        .trim();
  }

  String _getMarkdownURLFromPath(final String fullPath) {
    final String name = _getModuleNameFromPath(fullPath);
    final String rPath = path.relative(fullPath, from: Utils.baseDir);
    final String url = '${Utils.ghMainBranchURL}/$rPath';

    return '[$name]($url)';
  }

  Map<String, Map<String, Benchmarks>> get results =>
      <String, Map<String, Benchmarks>>{
        ...animeResults,
        ...mangaResults,
      };

  int get passed => results.values.fold<int>(
        0,
        (final int value, final Map<String, Benchmarks> x) =>
            value + x.values.where((final Benchmarks x) => x.success).length,
      );

  int get failed => results.values.fold<int>(
        0,
        (final int value, final Map<String, Benchmarks> x) =>
            value + x.values.where((final Benchmarks x) => !x.success).length,
      );

  String get summary {
    final String animeTable = _createMarkdownTable(
      <String, String>{
        'name': 'Name',
        'search': '`search`',
        'getInfo': '`getInfo`',
        'getSources': '`getSources`',
      },
      animeResults.entries
          .map(
            (final MapEntry<String, Map<String, Benchmarks>> x) =>
                <String, String>{
              'name': _getMarkdownURLFromPath(x.key),
              'search': _getValueFromBenchmarks(x.value['search']!),
              'getInfo': _getValueFromBenchmarks(x.value['getInfo']!),
              'getSources': _getValueFromBenchmarks(x.value['getSources']!),
            },
          )
          .toList(),
    );

    final String mangaTable = _createMarkdownTable(
      <String, String>{
        'name': 'Name',
        'search': '`search`',
        'getInfo': '`getInfo`',
        'getChapter': '`getChapter`',
        'getPage': '`getPage`',
      },
      mangaResults.entries
          .map(
            (final MapEntry<String, Map<String, Benchmarks>> x) =>
                <String, String>{
              'name': _getMarkdownURLFromPath(x.key),
              'search': _getValueFromBenchmarks(x.value['search']!),
              'getInfo': _getValueFromBenchmarks(x.value['getInfo']!),
              'getChapter': _getValueFromBenchmarks(x.value['getChapter']!),
              'getPage': _getValueFromBenchmarks(x.value['getPage']!),
            },
          )
          .toList(),
    );

    return '''
# 👨‍⚕️ Tenka Modules Checkup

Last checked at ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now().toUtc())} (UTC).

## Anime

$animeTable

## Manga

$mangaTable
''';
  }
}

Future<void> main(final List<String> args) async {
  final bool ci = args.contains('--ci');

  await Procedure.run(() async {
    final TestAll tester = TestAll(verbose: !ci);
    await tester.init();

    final List<Future<void> Function()> fns = <Future<void> Function()>[
      ...TestFiles.anime.entries.map(
        (final MapEntry<TenkaLocalFileDS, MockedAnimeExtractor> x) =>
            () => tester.run(
                  TenkaType.anime,
                  x.key,
                  () => x.value.run(
                    x.key,
                    verbose: !ci,
                  ),
                ),
      ),
      ...TestFiles.manga.entries.map(
        (final MapEntry<TenkaLocalFileDS, MockedMangaExtractor> x) =>
            () => tester.run(
                  TenkaType.manga,
                  x.key,
                  () => x.value.run(
                    x.key,
                    verbose: !ci,
                  ),
                ),
      ),
    ];

    if (ci) {
      await Utils.parallel(fns, concurrent: 3);
    } else {
      await Utils.sequencial(fns);
    }

    await tester.finish();
  });
}
