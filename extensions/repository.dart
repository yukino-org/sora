import 'dart:io';
import 'package:extensions_dev_tools/tools.dart';
import 'package:path/path.dart' as path;
import './anime/gogoanime_pe/config.dart' as gogoanime_pe;
import './anime/hanime_tv/config.dart' as hanime_tv;
import './anime/tenshi_moe/config.dart' as tenshi_moe;
import './anime/twist_moe/config.dart' as twist_moe;
import './anime/zoro_to/config.dart' as zoro_to;
import './manga/fanfox_net/config.dart' as fanfox_net;
import './manga/mangadex_org/config.dart' as mangadex_org;
import './manga/readm_org/config.dart' as readm_org;

final String _dirname = path.join(Directory.current.path, 'dist');

final EConfigRepository repository = EConfigRepository(<EConfig>[
  gogoanime_pe.config,
  hanime_tv.config,
  tenshi_moe.config,
  twist_moe.config,
  zoro_to.config,
  fanfox_net.config,
  mangadex_org.config,
  readm_org.config,
]);

Future<void> main() async {
  await repository.compileAll(ECompileAllOptions(outputDir: _dirname));
}
