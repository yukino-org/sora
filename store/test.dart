import 'package:sora_builder/sora_builder.dart';
import 'core/modules.dart';
import 'core/paths.dart';
import 'core/urls.dart';

Future<void> main(final List<String> args) async {
  final SoraTester tester = SoraTester(
    modules: $modules,
    paths: $paths,
    urls: $urls,
  );
  await tester.initialize();
  await tester.test();
  await tester.dispose();
}
