abstract class Emojis {
  static const String tick = '✔️';
  static const String cross = '❌';

  // ignore: avoid_positional_boolean_parameters
  static String fromBool(final bool value) => value ? tick : cross;
}
