 import 'package:flenex/flenex.dart';
import 'package:get/get.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/models/event_meet_manager.dart';
import 'package:iara/ui/screens/status/controllers/meet_connection_controller.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController  {
  final  Rx<Lenex?> _lenex =  Rx<Lenex?>(null);
  Lenex? get lenex => _lenex.value;
  Meet? meetSelected;
  final _infoText = ''.obs;
  get infoText => _infoText.value;
  final listening = false.obs;
  final _connectionController = Get.find<MeetConnectionController>();
  Function(String)? errorCallback;

  ConnectionStatus get status => _connectionController.status;

  @override
  void onInit() async {
    super.onInit();
    _connectionController.rxData.subject.listen((event) {
      if (event is EventMeetMannager) {
        if (event.type == 'downloadEvent') {
          var lenex = event.data as Lenex?;
          meetSelected = lenex?.meets?.first;
          _lenex.value = lenex;
          update();
        }

      }
      Logger().d(event);
    });
    _connectionController.status.obs.listen((p0) {
      Logger().d(p0);
    });
  }





  Future<void> clear() async {
    listening.value = false;
    update();
  }

  void setMeet(Meet? meet) {
    if (meet != null) {
      return;
    }
    Logger().d(meet);
    meetSelected = meet;
    update();
  }


}
