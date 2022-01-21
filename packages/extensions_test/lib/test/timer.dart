// ignore_for_file: avoid_print
import 'package:colorize/colorize.dart';

class TestTimer {
  late final int started;

  void start() {
    started = DateTime.now().millisecondsSinceEpoch;
  }

  void pass() {
    print(
      '${Colorize('✓').green()} Passed in ${Colorize('${elapsed}ms').green()}',
    );
  }

  void fail() {
    print(
      '${Colorize('✕').red()} Failed in ${Colorize('${elapsed}ms').red()}',
    );
  }

  int get elapsed => DateTime.now().millisecondsSinceEpoch - started;
}
