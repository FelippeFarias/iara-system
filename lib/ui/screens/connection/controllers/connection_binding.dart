import 'package:iara/ui/screens/serial/controllers/serial_controller.dart';
import 'package:iara/ui/screens/socket/controllers/socket_controller.dart';
import 'package:get/get.dart';

import 'connection_controller.dart';


class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocketController());
    Get.lazyPut(() => SerialController());
    Get.lazyPut(() => ConnectionController());
  }

}