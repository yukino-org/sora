import 'dart:io';
import 'package:path/path.dart' as p;

abstract class Paths {
  static final String rootDir = p.dirname(Directory.current.path);
  static final String animeDir = p.join(rootDir, 'modules/anime');
  static final String mangaDir = p.join(rootDir, 'modules/manga');

  static final String summaryDir = p.join(rootDir, 'dist/summary');
  static final String summaryReadme = p.join(summaryDir, 'README.md');
  static final String summaryBadge = p.join(summaryDir, 'badge.json');

  static String getAnimeModuleDir(final String id) => p.join(animeDir, id);
  static String getMangaModuleDir(final String id) => p.join(mangaDir, id);

  static String pretty(final String path) =>
      p.normalize(path).replaceAll(RegExp(r'[\\/]'), '/');
}
