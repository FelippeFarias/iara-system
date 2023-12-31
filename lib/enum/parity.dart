enum Parity {
  NOPARITY,
  ODDPARITY,
  EVENPARITY,
  MARKPARITY,
  SPACEPARITY,
}

extension ParityExtension on Parity {
  int get value {
    switch (this) {
      case Parity.NOPARITY:
        return 0;
      case Parity.ODDPARITY:
        return 1;
      case Parity.EVENPARITY:
        return 2;
      case Parity.MARKPARITY:
        return 3;
      case Parity.SPACEPARITY:
        return 4;
      default:
        throw Exception('Unknown parity type');
    }
  }
  String get humanizedName {
    switch (this) {
      case Parity.NOPARITY:
        return "None";
      case Parity.ODDPARITY:
        return "Odd";
      case Parity.EVENPARITY:
        return "Even";
      case Parity.MARKPARITY:
        return "Mark";
      case Parity.SPACEPARITY:
        return "Space";
      default:
        return "Unknown Parity";
    }
  }
  static int fromName(String name) {
    switch (name) {
      case "None":
        return Parity.NOPARITY.value;
      case "Odd":
        return Parity.ODDPARITY.value;
      case "Even":
        return Parity.EVENPARITY.value;
      case "Mark":
        return Parity.MARKPARITY.value;
      case "Space":
        return Parity.SPACEPARITY.value;
      default:
        throw ArgumentError('Unknown parity name: $name');
    }
  }
}
