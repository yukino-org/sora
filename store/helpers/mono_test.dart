import 'package:sora_builder/sora_builder.dart';
import 'package:tenka/tenka.dart';
import '../core/paths.dart';
import '../core/urls.dart';

Future<void> $test(final SoraBaseModule<dynamic> module) async {
  final SoraTester tester = SoraTester(
    modules: SoraModules(
      anime: <SoraAnimeModule>[
        if (module.type() == TenkaType.anime) module as SoraAnimeModule,
      ],
      manga: <SoraMangaModule>[
        if (module.type() == TenkaType.manga) module as SoraMangaModule,
      ],
    ),
    paths: $paths,
    urls: $urls,
  );
  await tester.initialize();
  await tester.test(summarize: false);
  await tester.dispose();
}
