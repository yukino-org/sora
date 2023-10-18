import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../../../store/core/module.dart';
import '../../../store/test.dart';
import 'module.dart';

Future<void> main() async {
  final SAnimeModule module = AnimePahe();
  final TenkaMetadata config = await module.config();
  final MockedAnimeExtractor mocked = module.mock();
  await STester.runProcedure(
    () => mocked.run(config.source as TenkaLocalFileDS),
  );
}
