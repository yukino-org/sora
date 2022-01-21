import 'package:extensions/extensions.dart';
// ignore: depend_on_referenced_packages
import 'package:utilx/utilities/locale.dart';

abstract class TestEnvironmentManager {
  static const Locale defaultLocale = Locale(LanguageCodes.en);

  static Future<void> prepare() async {
    await ExtensionInternals.initialize(
      httpOptions: const HttpClientOptions(ignoreSSLCertificate: true),
      webviewProviderOptions: const WebviewProviderOptions(),
    );
  }

  static Future<void> dispose() async {
    await ExtensionInternals.dispose();
  }
}
