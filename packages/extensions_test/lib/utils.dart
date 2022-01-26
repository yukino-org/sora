import 'package:colorize/colorize.dart';

bool _isKindOfMap(final dynamic data) =>
    data is Map<dynamic, dynamic> || data is Iterable<dynamic>;

String prettify(
  final dynamic data, {
  final String spacing = '',
  final String tabSpace = '    ',
  final bool isKey = false,
  final String? previous,
}) {
  final List<String> lines = <String>[
    if (previous != null) previous,
  ];

  if (_isKindOfMap(data)) {
    final Map<dynamic, dynamic> entries;

    final bool isList = data is Iterable<dynamic>;
    final bool isMap = data is Map<dynamic, dynamic>;

    if (isMap) {
      entries = data;
    } else if (isList) {
      entries = data.toList().asMap();
    } else {
      throw Exception("Shouldn't be here");
    }

    for (final MapEntry<dynamic, dynamic> entry in entries.entries) {
      final bool isValueKindOfMap = _isKindOfMap(entry.value);

      final String prefix = Colorize(
        isList ? '- ' : '',
      ).darkGray().toString();

      final String key = prettify(
        entry.key,
        isKey: true,
        tabSpace: tabSpace,
      );

      final String center =
          Colorize(':${isValueKindOfMap ? '\n' : ' '}').darkGray().toString();

      final String value = prettify(
        entry.value,
        spacing: isValueKindOfMap ? spacing + tabSpace : '',
        tabSpace: tabSpace,
      );

      lines.add('$spacing$prefix$key$center$value');
    }
  } else {
    final Colorize colorizedData = Colorize(data.toString());

    if (data is num) {
      colorizedData.green();
    } else if (isKey && data is String) {
      colorizedData.cyan().toString();
    }

    lines.add('$spacing$colorizedData');
  }

  return lines.join('\n').replaceAllMapped(
        RegExp(
          r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
        ),
        (final Match match) => Colorize(match.group(0)!).underline().toString(),
      );
}
