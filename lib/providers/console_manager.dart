import 'package:dart_console/dart_console.dart';

class ConsoleManager {
  // Instância singleton
  static final ConsoleManager _instance = ConsoleManager._internal();

  // Instância do console
  final Console _console = Console();

  // Construtor privado
  ConsoleManager._internal();

  // Factory constructor para acessar a instância
  factory ConsoleManager() {
    return _instance;
  }

  // Métodos para expor a funcionalidade do console
  void setBackgroundColor(ConsoleColor color) {
    _console.setBackgroundColor(color);
  }

  void setForegroundColor(ConsoleColor color) {
    _console.setForegroundColor(color);
  }

  void writeLine(String text, {TextAlignment alignment = TextAlignment.left,ConsoleColor color = ConsoleColor.white}) {
    _console.setForegroundColor(color);
    _console.writeLine(text, alignment);
    _console.resetColorAttributes();
  }

  void resetColorAttributes() {
    _console.resetColorAttributes();
  }

  int get windowWidth => _console.windowWidth;
  int get windowHeight => _console.windowHeight;
}
