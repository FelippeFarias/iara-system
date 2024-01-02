import 'package:get/get.dart';

import 'meet_connection_controller.dart';

class MeetConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => MeetConnectionController());
  }

}