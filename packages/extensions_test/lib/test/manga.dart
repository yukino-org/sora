// ignore_for_file: avoid_print

import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:test/test.dart';
// ignore: depend_on_referenced_packages
import 'package:utilx/utilities/locale.dart';
import './environment.dart';
import './timer.dart';
import '../utils.dart';

class MangaExtractorTest {
  const MangaExtractorTest(this.extractor);

  final MangaExtractor extractor;

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
    final MangaInfo result = await extractor.getInfo(url, locale);

    print('Result:');
    print(prettify(result.toJson(), spacing: '  '));

    timer.pass();
  }

  Future<void> getChapter(final ChapterInfo chapter) async {
    final TestTimer timer = TestTimer()..start();
    final List<PageInfo> result = await extractor.getChapter(chapter);

    print('Results (${result.length}):');
    print(
      prettify(result.map((final PageInfo x) => x.toJson()), spacing: '  '),
    );

    if (result.isEmpty) {
      timer.fail();
      throw Exception('Empty result');
    }

    timer.pass();
  }

  Future<void> getPage(final PageInfo page) async {
    final TestTimer timer = TestTimer()..start();
    final ImageDescriber result = await extractor.getPage(page);

    print('Result:');
    print(prettify(result.toJson(), spacing: '  '));

    timer.pass();
  }

  static Future<void> testFile(
    final String path, {
    required final Future<void> Function(MangaExtractorTest) search,
    required final Future<void> Function(MangaExtractorTest) getInfo,
    required final Future<void> Function(MangaExtractorTest) getChapter,
    required final Future<void> Function(MangaExtractorTest) getPage,
  }) async {
    setUpAll(() async {
      await TestEnvironmentManager.prepare();
    });

    const String? method =
        bool.hasEnvironment('method') ? String.fromEnvironment('method') : null;
    final DateTime now = DateTime.now();
    final List<String> methods = method != null
        ? method.split(',')
        : <String>['search', 'getInfo', 'getChapter', 'getPage'];

    final File script = File(path);
    final ResolvedExtension extenstion = ResolvedExtension(
      name: 'test',
      id: 'test',
      author: 'test',
      defaultLocale: TestEnvironmentManager.defaultLocale,
      version: ExtensionVersion(now.year, now.month, 0),
      type: ExtensionType.manga,
      code: await script.readAsString(),
      image: '',
      nsfw: false,
    );

    final MangaExtractor extractor =
        await ExtensionInternals.transpileToMangaExtractor(extenstion);
    final MangaExtractorTest client = MangaExtractorTest(extractor);

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

    if (methods.contains('getChapter')) {
      test('getChapter', () async {
        await getChapter(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      });
    }

    if (methods.contains('getPage')) {
      test('getPage', () async {
        await getPage(client);
        await Future<void>.delayed(const Duration(seconds: 3));
      });
    }

    tearDownAll(() async {
      await TestEnvironmentManager.dispose();
    });
  }
}
