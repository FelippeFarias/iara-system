import 'package:get/get.dart';

import 'socket_controller.dart';

class SocketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocketController());
  }

}