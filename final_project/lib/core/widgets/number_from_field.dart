import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFromField extends StatelessWidget {
  const NumberFromField({
    super.key,
    this.hintText,
    this.validator,
    this.keyboardType,
  });

  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [_PhoneMaskFormatter()],
      decoration: InputDecoration(hintText: hintText),
      validator: validator,
    );
  }
}

class _PhoneMaskFormatter extends TextInputFormatter {
  String realNumber = '';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    if (newText.length < oldValue.text.length) {
      if (realNumber.isNotEmpty) {
        realNumber = realNumber.substring(0, realNumber.length - 1);
      }
    } else {
      final lastChar = newText.isNotEmpty ? newText[newText.length - 1] : '';

      if (RegExp(r'[0-9]').hasMatch(lastChar)) {
        if (realNumber.length < 11) {
          realNumber += lastChar;
        }
      }
    }

    String masked = '';
    for (int i = 0; i < realNumber.length; i++) {
      if (i < 2) {
        masked += realNumber[i];
      } else {
        masked += 'x';
      }
    }

    return TextEditingValue(
      text: masked,
      selection: TextSelection.collapsed(offset: masked.length),
    );
  }
}
