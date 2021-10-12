import 'dart:io';
import 'package:extensions/extensions.dart';
import 'package:extensions/test.dart';
import 'package:test/test.dart';

Future<void> run(
  String path, {
  required final Future<void> Function(AnimeExtractorTest) search,
  required final Future<void> Function(AnimeExtractorTest) getInfo,
  required final Future<void> Function(AnimeExtractorTest) getSources,
}) async {
  const String? method =
      bool.hasEnvironment('method') ? String.fromEnvironment('method') : null;
  final DateTime now = DateTime.now();
  final List<String> methods =
      method != null ? [method] : ['search', 'getInfo', 'getSources'];

  final script = File(path);
  final extenstion = ResolvedExtension(
    name: 'test',
    id: 'test',
    version: ExtensionVersion(now.year, now.month, 0),
    type: ExtensionType.anime,
    code: await script.readAsString(),
    image: '',
    nsfw: false,
  );
  final extractor = await ExtensionUtils.transpileToAnimeExtractor(extenstion);
  final client = AnimeExtractorTest(extractor);

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

  if (methods.contains('getSources')) {
    test('getSources', () async {
      await getSources(client);
      await Future.delayed(const Duration(seconds: 3));
    });
  }
}
