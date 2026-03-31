import 'package:flutter/services.dart';

class PrefixFormatter extends TextInputFormatter {
  final String prefix;

  PrefixFormatter({required this.prefix});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || newValue.text == prefix) {
      // print('calling prefix');
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (newValue.text.startsWith(prefix)) {
      return newValue;
    }

    // if (!newValue.text.startsWith(prefix)) {
      final textWithoutPrefix = newValue.text;
      final newText = prefix + textWithoutPrefix;

      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    // }
    // return newValue;
  }
}
