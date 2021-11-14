import 'package:extensions/extensions.dart';

Future<void> prepareExtensionsManager() async {
  await ExtensionInternals.initialize();
}

Future<void> disposeExtensionsManager() async {
  await ExtensionInternals.dispose();
}
