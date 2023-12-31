import 'package:iara/intl/lang_constants.dart';
import 'package:get/get.dart';

enum ConnectionStatus {
  disconnected,
  reconnecting,
  connecting,
  connected,
  failed,
}

extension ConnectionStatusExtension on ConnectionStatus {
  String get humanizedName {
    switch (this) {
      case ConnectionStatus.disconnected: return LangConstants.disconnected.tr;
      case ConnectionStatus.reconnecting: return LangConstants.reconnecting.tr;
      case ConnectionStatus.connecting: return LangConstants.connecting.tr;
      case ConnectionStatus.connected: return LangConstants.connected.tr;
      case ConnectionStatus.failed: return LangConstants.failed.tr;
      default: return LangConstants.disconnected.tr;
    }
  }
}