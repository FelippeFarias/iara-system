enum SerialBaud {
  CBR_600,
  CBR_1200,
  CBR_2400,
  CBR_4800,
  CBR_9600,
  CBR_14400,
  CBR_19200,
  CBR_38400,
  CBR_57600,
  CBR_115200,
}

extension SerialBaudExtension on SerialBaud {
  int get value {
    switch (this) {
      case SerialBaud.CBR_600:
        return 600;
      case SerialBaud.CBR_1200:
        return 1200;
      case SerialBaud.CBR_2400:
        return 2400;
      case SerialBaud.CBR_4800:
        return 4800;
      case SerialBaud.CBR_9600:
        return 9600;
      case SerialBaud.CBR_14400:
        return 14400;
      case SerialBaud.CBR_19200:
        return 19200;
      case SerialBaud.CBR_38400:
        return 38400;
      case SerialBaud.CBR_57600:
        return 57600;
      case SerialBaud.CBR_115200:
        return 115200;
      default:
    return 9600;
    }
  }
}
