import 'package:path/path.dart' as p;

abstract class SoraPaths {
  String rootDir();

  String getAnimeModuleDir(final String id) => p.join(animeModulesDir, id);
  String getMangaModuleDir(final String id) => p.join(mangaModulesDir, id);
  String getGeneratedConfigPath(final String dir) => p.join(dir, '_data.json');
  String getModuleMainScriptFile(final String dir) =>
      p.join(dir, 'src/main.beize');
  String getModuleLogoFile(final String dir) => p.join(dir, 'logo.png');

  String get _rootDir => rootDir();
  String get modulesDir => p.join(_rootDir, 'modules');
  String get animeModulesDir => p.join(modulesDir, 'anime');
  String get mangaModulesDir => p.join(modulesDir, 'manga');
  String get storeOutputDir => p.join(_rootDir, 'dist');
  String get storeOutputDataDir => p.join(storeOutputDir, 'data');
  String get storeOutputJsonPath => p.join(storeOutputDir, 'store.json');
  String get storeOutputChecksumPath => p.join(storeOutputDir, 'store.sha256');
  String get summaryOutputDir => p.join(_rootDir, 'dist-summary');
  String get summaryOutputReadmePath => p.join(summaryOutputDir, 'README.md');
  String get summaryOutputBadgePath => p.join(summaryOutputDir, 'badge.json');
}
