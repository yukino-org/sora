// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utils.dart';
import 'core/module.dart';
import 'core/modules.dart';
import 'utils/constants.dart';
import 'utils/emojis.dart';
import 'utils/paths.dart';
import 'utils/runner.dart';

class STester {
  final Map<String, Map<String, Benchmarks>> animeResults =
      <String, Map<String, Benchmarks>>{};

  final Map<String, Map<String, Benchmarks>> mangaResults =
      <String, Map<String, Benchmarks>>{};

  Future<void> run(
    final TenkaType type,
    final TenkaLocalFileDS source,
    final Future<Map<String, Benchmarks>> Function() fn,
  ) async {
    final String k =
        '${Colorize(p.basename(p.dirname(source.root))).cyan()} ${Colorize('(${Paths.pretty(source.fullPath)})').darkGray()}';

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
  }

  Future<void> finish() async {
    print(
      'Full Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
    );

    for (final MapEntry<String, Map<String, Benchmarks>> x in results.entries) {
      print(
        ' ${Colorize('*').darkGray()} ${Colorize(_getModuleNameFromPath(x.key)).cyan()} ${Colorize('(${Paths.pretty(x.key)})').darkGray()}',
      );

      for (final MapEntry<String, Benchmarks> y in x.value.entries) {
        print(
          '    ${Colorize('*').darkGray()} ${Colorize('${y.key}()').cyan()}: ${y.value.success ? Colorize('P').green() : Colorize('F').red()}',
        );
      }
    }

    final File summaryReadmeFile = File(Paths.summaryReadme);
    await FSUtils.ensureFile(summaryReadmeFile);
    await summaryReadmeFile.writeAsString(summary);

    final File summaryBadgeFile = File(Paths.summaryBadge);
    await FSUtils.ensureFile(summaryBadgeFile);
    await summaryBadgeFile.writeAsString(
      jsonEncode(<dynamic, dynamic>{
        'schemaVersion': 1,
        'label': 'test-modules',
        'message': '$passed passed, $failed failed',
        'color': '4b3fd1',
      }),
    );
  }

  String _getModuleNameFromPath(final String fullPath) =>
      p.basename(p.dirname(p.dirname(fullPath)));

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
    final String rPath = p.relative(fullPath, from: Paths.rootDir);
    final String url =
        '${Constants.ghMainBranchURL}/$rPath'.replaceAll(RegExp(r'\\'), '/');

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
        'getSource': '`getSource`',
      },
      animeResults.entries
          .map(
            (final MapEntry<String, Map<String, Benchmarks>> x) =>
                <String, String>{
              'name': _getMarkdownURLFromPath(x.key),
              'search': _getValueFromBenchmarks(x.value['search']!),
              'getInfo': _getValueFromBenchmarks(x.value['getInfo']!),
              'getSource': _getValueFromBenchmarks(x.value['getSource']!),
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

  static Future<void> runProcedure(final Future<void> Function() fn) async {
    await TenkaDevEnvironment.prepare();
    await fn();
    await TenkaDevEnvironment.dispose();
  }
}

Future<void> main(final List<String> args) async {
  final bool ci = args.contains('--ci');
  final STester tester = STester();
  final List<Future<void> Function()> fns = <Future<void> Function()>[
    ...SModules.anime.map(
      (final SAnimeModule x) => () async {
        final TenkaMetadata config = await x.config();
        final TenkaLocalFileDS source = config.source as TenkaLocalFileDS;
        final MockedAnimeExtractor mocked = x.mock();
        return tester.run(
          TenkaType.anime,
          source,
          () => mocked.run(source),
        );
      },
    ),
    ...SModules.manga.map(
      (final SMangaModule x) => () async {
        final TenkaMetadata config = await x.config();
        final TenkaLocalFileDS source = config.source as TenkaLocalFileDS;
        final MockedMangaExtractor mocked = x.mock();
        return tester.run(
          TenkaType.manga,
          source,
          () => mocked.run(source),
        );
      },
    ),
  ];
  await STester.runProcedure(() async {
    if (ci) {
      await Runner.parallel(fns, concurrent: 3);
    } else {
      await Runner.sequencial(fns);
    }
  });
  await tester.finish();
}
