import 'dart:io';
import 'package:path/path.dart' as path;
import '../tools/utils.dart';

Future<void> main() async {
  for (final String x in <String>[Utils.animeDir, Utils.mangaDir]) {
    await for (final FileSystemEntity y in Directory(x).list()) {
      if (y is! Directory) throw Error();

      final File testFile = File(path.join(y.path, 'test.dart'));
      final Process cProcess = await Process.start(
        'dart',
        <String>[
          'run',
          testFile.path,
        ],
        mode: ProcessStartMode.inheritStdio,
      );
      if ((await cProcess.exitCode) != 0) {
        throw Exception('Test failed: ${Utils.prettyPath(testFile.path)}');
      }
    }
  }
}
