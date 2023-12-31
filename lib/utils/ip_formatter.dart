import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IPFormatter {
  final MaskTextInputFormatter _maskFormatter;

  IPFormatter()
      : _maskFormatter = MaskTextInputFormatter(
    mask: '###.###.###.###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Função para obter o formatter atualizado
  TextInputFormatter get formatter => _maskFormatter;

  // Função para ajustar a máscara
  void updateMask(String text) {
    // Separa o texto em segmentos baseados no ponto
    List<String> segments = text.split('.');

    // Função auxiliar para determinar a máscara para um segmento
    String segmentMask(String segment) {
      switch (segment.length) {
        case 1:
          return '#';
        case 2:
          return '##';
        default:
          return '###';
      }
    }

    // Constrói a nova máscara com base nos segmentos
    String newMask = '';
    for (int i = 0; i < segments.length; i++) {
      if (i > 0) {
        newMask += '.';
      }
      newMask += segmentMask(segments[i]);
      // Adiciona segmentos faltantes à máscara
      if (i < segments.length - 1) {
        newMask += '.###';
      }
    }

    // Atualiza a máscara
    _maskFormatter.updateMask(mask: newMask);
  }
}
