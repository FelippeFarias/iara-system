import 'package:get/get.dart';

import '../enum/connection_status.dart';

abstract class ConnectionInterface {
  void onReconnecting(int reconnectionAttempts);

  void onConnected();

  void onDisconnected();

  void onError(dynamic error);

  void onData(dynamic data);

  ConnectionStatus getStatus();
  String get name;
  String get details;
  Rx<dynamic> streamData();
}
