import 'package:flutter/services.dart';

class FixedLengthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove caracteres não numéricos
    String numericOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Verifica se está adicionando ou removendo caracteres
    bool isAdding = oldValue.text.length < newValue.text.length;

    if (isAdding) {
      // Ao adicionar: preenche com zeros à esquerda e mantém os últimos 5 caracteres
      numericOnly = numericOnly.padLeft(5, '0');
      numericOnly = numericOnly.substring(numericOnly.length - 5);

      // Limita o valor a no máximo "99998"
      if (int.parse(numericOnly) > 99998) {
        numericOnly = '99998';
      }
    } else {
      // Ao remover: preenche com zeros à esquerda, desloca os números para a esquerda e adiciona um zero à direita
      numericOnly = numericOnly.padLeft(5, '0').substring(0, numericOnly.length) + '0';
    }

    return TextEditingValue(
      text: numericOnly,
      // Move o cursor para o final
      selection: TextSelection.collapsed(offset: numericOnly.length),
    );
  }
}
