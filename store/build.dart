import 'package:sora_builder/sora_builder.dart';
import 'core/modules.dart';
import 'core/paths.dart';
import 'core/urls.dart';

Future<void> main() async {
  final SoraBuilder builder = SoraBuilder(
    modules: $modules,
    paths: $paths,
    urls: $urls,
  );
  await builder.initialize();
  await builder.build();
  await builder.dispose();
}
