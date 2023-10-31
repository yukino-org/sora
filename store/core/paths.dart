import 'dart:io';
import 'package:sora_builder/sora_builder.dart';

class _Paths extends SoraPaths {
  @override
  String rootDir() => Directory.current.path;
}

final _Paths $paths = _Paths();
