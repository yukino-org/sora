// ignore_for_file: avoid_print

import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:test/test.dart';
// ignore: depend_on_referenced_packages
import 'package:utilx/utilities/locale.dart';
import './environment.dart';
import './timer.dart';
import '../utils.dart';

class AnimeExtractorTest {
  const AnimeExtractorTest(this.extractor);

  final AnimeExtractor extractor;

  Future<void> search(final String terms, final Locale locale) async {
    final TestTimer timer = TestTimer()..start();
    final List<SearchInfo> result = await extractor.search(terms, locale);

    print('Results (${result.length}):');
    print(
      prettify(
        result.map((final SearchInfo x) => x.toJson()),
        spacing: '  ',
      ),
    );

    if (result.isEmpty) {
      timer.fail();
      throw Exception('Empty result');
    }

    timer.pass();
  }

  Future<void> getInfo(final String url, final Locale locale) async {
    final TestTimer timer = TestTimer()..start();
    final AnimeInfo result = await extractor.getInfo(url, locale);

    print('Result:');
    print(prettify(result.toJson(), spacing: '  '));

    timer.pass();
  }

  Future<void> getSources(final EpisodeInfo episode) async {
    final TestTimer timer = TestTimer()..start();
    final List<EpisodeSource> result = await extractor.getSources(episode);

    print('Results (${result.length}):');
    print(
      prettify(
        result.map((final EpisodeSource x) => x.toJson()),
        spacing: '  ',
      ),
    );

    if (result.isEmpty) {
      timer.fail();
      throw Exception('Empty result');
    }

    timer.pass();
  }

  static Future<void> testFile(
    final String path, {
    required final Future<void> Function(AnimeExtractorTest) search,
    required final Future<void> Function(AnimeExtractorTest) getInfo,
    required final Future<void> Function(AnimeExtractorTest) getSources,
  }) async {
    setUpAll(() async {
      await TestEnvironmentManager.prepare();
    });

    const String? method =
        bool.hasEnvironment('method') ? String.fromEnvironment('method') : null;
    final DateTime now = DateTime.now();
    final List<String> methods = method != null
        ? <String>[method]
        : <String>['search', 'getInfo', 'getSources'];

    final File script = File(path);
    final ResolvedExtension extenstion = ResolvedExtension(
      name: 'test',
      id: 'test',
      author: 'test',
      defaultLocale: TestEnvironmentManager.defaultLocale,
      version: ExtensionVersion(now.year, now.month, 0),
      type: ExtensionType.anime,
      code: await script.readAsString(),
      image: '',
      nsfw: false,
    );

    final AnimeExtractor extractor =
        await ExtensionInternals.transpileToAnimeExtractor(extenstion);
    final AnimeExtractorTest client = AnimeExtractorTest(extractor);

    if (methods.contains('search')) {
      test('search', () async {
        await search(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      });
    }

    if (methods.contains('getInfo')) {
      test('getInfo', () async {
        await getInfo(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      });
    }

    if (methods.contains('getSources')) {
      test('getSources', () async {
        await getSources(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      });
    }

    tearDownAll(() async {
      await TestEnvironmentManager.dispose();
    });
  }
}
