import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions/test.dart';
import 'package:test/test.dart';

Future<void> run(
  String path, {
  required final Future<void> Function(MangaExtractorTest) search,
  required final Future<void> Function(MangaExtractorTest) getInfo,
  required final Future<void> Function(MangaExtractorTest) getChapter,
  required final Future<void> Function(MangaExtractorTest) getPage,
}) async {
  const String? method =
      bool.hasEnvironment('method') ? String.fromEnvironment('method') : null;
  final DateTime now = DateTime.now();
  final List<String> methods = method != null
      ? [method]
      : ['search', 'getInfo', 'getChapter', 'getPage'];

  final script = File(path);
  final extenstion = ResolvedExtension(
    name: 'test',
    id: 'test',
    version: ExtensionVersion(now.year, now.month, 0),
    type: ExtensionType.manga,
    code: await script.readAsString(),
    image: '',
    nsfw: false,
  );
  final extractor = await ExtensionUtils.transpileToMangaExtractor(extenstion);
  final client = MangaExtractorTest(extractor);

  if (methods.contains('search')) {
    test('search', () async {
      await search(client);
      await Future.delayed(const Duration(seconds: 3));
    });
  }

  if (methods.contains('getInfo')) {
    test('getInfo', () async {
      await getInfo(client);
      await Future.delayed(const Duration(seconds: 3));
    });
  }

  if (methods.contains('getChapter')) {
    test('getChapter', () async {
      await getChapter(client);
      await Future.delayed(const Duration(seconds: 3));
    });
  }

  if (methods.contains('getPage')) {
    test('getPage', () async {
      await getPage(client);
      await Future.delayed(const Duration(seconds: 3));
    });
  }
}
