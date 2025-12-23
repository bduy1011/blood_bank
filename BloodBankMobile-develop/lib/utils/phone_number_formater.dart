import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 4 || i == 7)
        buffer.write(' '); // Add space at specific positions
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }

  static String formatString(String text) {
    var newText = text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      if (i == 4 || i == 7)
        buffer.write(' '); // Add space at specific positions
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}

class IdCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(' ', ''); // Remove spaces
    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      if (i != 0 && i % 3 == 0) {
        buffer.write(' '); // Add space after every 3 characters
      }
      buffer.write(newText[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  static String formatString(String text) {
    final buffer = StringBuffer();

    final newText = text.replaceAll(' ', ''); // Remove spaces

    for (int i = 0; i < newText.length; i++) {
      if (i != 0 && i % 3 == 0) {
        buffer.write(' '); // Add space after every 3 characters
      }
      buffer.write(newText[i]);
    }
    return buffer.toString();
  }
}
