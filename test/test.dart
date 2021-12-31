import 'package:extensions/extensions.dart';
// ignore: depend_on_referenced_packages
import 'package:utilx/utilities/locale.dart';

const defaultLocale = Locale(LanguageCodes.en);

Future<void> prepareExtensionsManager() async {
  await ExtensionInternals.initialize(
    httpOptions: const HetuHttpClient(
      ignoreSSLCertificate: true,
    ),
    htmlDOMOptions: const HtmlDOMOptions(),
  );
}

Future<void> disposeExtensionsManager() async {
  await ExtensionInternals.dispose();
}
