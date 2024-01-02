import 'package:iara/ui/screens/serial/controllers/serial_controller.dart';
import 'package:iara/ui/screens/socket/controllers/socket_controller.dart';
import 'package:get/get.dart';

import '../../status/controllers/meet_connection_controller.dart';
import 'connection_controller.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectionController());
    Get.lazyPut(() => MeetConnectionController());
    Get.lazyPut(() => SocketController());
    Get.lazyPut(() => SerialController());
  }
}
