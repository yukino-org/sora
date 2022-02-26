import 'dart:async';
import 'dart:io';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';

class _Procedure {
  final List<Future<void>> criticalFutures = <Future<void>>[];

  Future<void> run(final Future<void> Function() fn) async {
    ProcessSignal.sigint.watch().listen((final ProcessSignal _) {
      criticalFutures.add(quit());
    });

    await TenkaDevEnvironment.prepare();
    await fn();
    await quit();
  }

  Future<void> quit() async {
    await waitForCriticals();
    await TenkaDevEnvironment.dispose();
    exit(exitCode);
  }

  Future<void> waitForCriticals() async {
    await Future.wait(criticalFutures);
  }
}

abstract class Procedure {
  static Future<void> run(final Future<void> Function() fn) async {
    final _Procedure procedure = _Procedure();
    await procedure.run(fn);
  }
}
