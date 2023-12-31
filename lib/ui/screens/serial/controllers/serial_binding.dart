import 'package:get/get.dart';

import 'serial_controller.dart';

class SerialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SerialController());
  }

}