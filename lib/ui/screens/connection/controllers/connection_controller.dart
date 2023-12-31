import 'package:iara/enum/connection_status.dart';
import 'package:get/get.dart';

import '../../../../interfaces/connection_interface.dart';

class ConnectionController extends GetxController  {

  final Rx<ConnectionInterface?> _connection = Rx<ConnectionInterface?>(null);
  ConnectionInterface? get connection => _connection.value;
  ConnectionStatus get status => _connection.value?.getStatus() ?? ConnectionStatus.disconnected;

  Function(ConnectionStatus)? statusCallback;

  set connection(ConnectionInterface? value) => _connection.value = value;

  @override
  void onInit() {
    super.onInit();
    _connection.listen((p0) {
      statusCallback?.call(  p0?.getStatus() ?? ConnectionStatus.disconnected);
    });
  }
}
