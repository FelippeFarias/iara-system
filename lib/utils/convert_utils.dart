import 'dart:convert';
import 'dart:typed_data';
import 'package:ninja_hex/ninja_hex.dart';

class ConvertUtils {
  // Converter String para Bytes
  static Uint8List stringToBytes(String str) {
    return Uint8List.fromList(utf8.encode(str));
  }

  // Converter Bytes para Hexadecimal
  static String bytesToHex(Uint8List bytes) {
    return bytes.toHex;
  }

  // Converter Hexadecimal para Bytes
  static Uint8List hexToBytes(String hex) {
    return hex.decodeHex;
  }

  // Converter Hexadecimal para BigInt
  static BigInt hexToBigInt(String hex) {
    return bigIntFromHex(hex);
  }

  // Visualização bonita de Hexadecimal
  static String prettyHexView(int start, Uint8List bytes) {
    return hexView(start, bytes);
  }
}
