import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DollarTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, 
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '\$');
    } else if (!newValue.text.startsWith('\$')) {
      return newValue.copyWith(text: '\$' + newValue.text.substring(1));
    }
    return newValue;
  }
}
