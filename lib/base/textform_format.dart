
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {

  NumberInputFormatter();
  final NumberFormat _numberFormat = NumberFormat('#,###');
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(newValue.text.replaceAll(_numberFormat.symbols.GROUP_SEP, ''));
    String newText = _numberFormat.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}