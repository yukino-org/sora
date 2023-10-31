// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import 'package:utilx/utils.dart';
import '../core/exports.dart';
import '../utils/exports.dart';

class SoraTester {
  SoraTester({
    required this.modules,
    required this.paths,
    required this.urls,
  });

  final SoraModules modules;
  final SoraPaths paths;
  final SoraUrls urls;

  final Map<String, Map<String, Benchmarks>> animeResults =
      <String, Map<String, Benchmarks>>{};
  final Map<String, Map<String, Benchmarks>> mangaResults =
      <String, Map<String, Benchmarks>>{};

  Future<void> initialize() async {
    await TenkaDevEnvironment.prepare();
  }

  Future<void> test({
    final bool summarize = true,
  }) async {
    for (final SoraAnimeModule x in modules.anime) {
      final TenkaMetadata config = await x.config();
      final TenkaLocalFileDS source = config.source as TenkaLocalFileDS;
      final MockedAnimeExtractor mocked = x.mock();
      await _test(TenkaType.anime, source, () => mocked.run(source));
    }
    for (final SoraMangaModule x in modules.manga) {
      final TenkaMetadata config = await x.config();
      final TenkaLocalFileDS source = config.source as TenkaLocalFileDS;
      final MockedMangaExtractor mocked = x.mock();
      await _test(TenkaType.manga, source, () => mocked.run(source));
    }
    if (summarize) {
      await _summarize();
    }
  }

  Future<void> dispose() async {
    await TenkaDevEnvironment.dispose();
  }

  Future<void> _test(
    final TenkaType type,
    final TenkaLocalFileDS source,
    final Future<Map<String, Benchmarks>> Function() fn,
  ) async {
    final String k =
        '${Colorize(p.basename(p.dirname(source.root))).cyan()} ${Colorize('(${source.fullPath})').darkGray()}';
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

  Future<void> _summarize() async {
    print(
      'Full Summary: [${Colorize('+$passed').green()} ${Colorize('-$failed').red()}]',
    );
    for (final MapEntry<String, Map<String, Benchmarks>> x
        in allResults.entries) {
      print(
        ' ${Colorize('*').darkGray()} ${Colorize(_getModuleNameFromPath(x.key)).cyan()} ${Colorize('(${x.key})').darkGray()}',
      );
      for (final MapEntry<String, Benchmarks> y in x.value.entries) {
        print(
          '    ${Colorize('*').darkGray()} ${Colorize('${y.key}()').cyan()}: ${y.value.success ? Colorize('P').green() : Colorize('F').red()}',
        );
      }
    }

    await FSUtils.ensureDirectory(Directory(paths.summaryOutputDir));
    final File summaryReadmeFile = File(paths.summaryOutputReadmePath);
    await summaryReadmeFile.writeAsString(summary);

    final File summaryBadgeFile = File(paths.summaryOutputBadgePath);
    await summaryBadgeFile.writeAsString(
      json.encode(<dynamic, dynamic>{
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
    final String rPath = p.relative(fullPath, from: paths.rootDir());
    final String url =
        '${urls.repositoryUrl()}/$rPath'.replaceAll(RegExp(r'\\'), '/');

    return '[$name]($url)';
  }

  Map<String, Map<String, Benchmarks>> get allResults =>
      <String, Map<String, Benchmarks>>{
        ...animeResults,
        ...mangaResults,
      };

  int get passed => allResults.values.fold<int>(
        0,
        (final int value, final Map<String, Benchmarks> x) =>
            value + x.values.where((final Benchmarks x) => x.success).length,
      );

  int get failed => allResults.values.fold<int>(
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
# 👨‍⚕️ Modules Checkup

Last checked at ${DateTime.now().toUtc().toString().replaceFirst(r'\.\d+Z', '')} (UTC).

## Anime

$animeTable

## Manga

$mangaTable
''';
  }
}
