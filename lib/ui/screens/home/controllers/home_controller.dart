import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/models/readers.dart';
import 'package:iara/providers/directories_controller.dart';
import 'package:iara/services/file_service.dart';
import 'package:iara/ui/screens/connection/controllers/connection_controller.dart';
import 'package:iara/utils/asset_paths.dart';
import 'package:iara/utils/convert_utils.dart';
import 'package:iara/utils/file_utils.dart';
import 'package:iara/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../database/readers_db_helper.dart';
import '../../../../interfaces/stream_files.dart';
import '../../../../models/athlete_item.dart';
import '../../../../models/athlete_management.dart';
import '../../../../models/chip_data.dart';
import '../../../components/terminal_widget/flutter_console_controller.dart';

class HomeController extends GetxController implements StreamFiles {
  final eventCodeController = TextEditingController();
  final chipStartNumberController = TextEditingController();
  final chipEndNumberController = TextEditingController();
  final _directories = Get.find<DirectoriesController>();
  AthleteManagement? athleteManagement;
  final _eventCode = ''.obs;
  final _infoText = ''.obs;

  get infoText => _infoText.value;
  final listening = false.obs;
  final formKey = GlobalKey<FormState>();
  final player = AudioPlayer();
  final _connectionController = Get.find<ConnectionController>();
  FileService? fs;
  Function(String)? errorCallback;
  final FlutterConsoleController tc = FlutterConsoleController();

  set eventCode(String value) {
    _eventCode.value = value.padLeft(5, '0');
  }

  ConnectionStatus get status => _connectionController.status;
  final readersDB = ReadersDbHelper();
  Readers? reader;

  @override
  void onInit() async {
    super.onInit();

    _connectionController.statusCallback = _handleConnectionStatus;
    reader = await readersDB.getLastReader();
    if (reader != null) {
      athleteManagement = reader!.athleteManagement;
      eventCode = reader!.eventCode;
      update();
    }
    eventCodeController.text = eventCode;
  }

  Future<void> handleData(String data) async {
    if (data.isEmpty) {
      return;
    }
    var dataObj = jsonDecode(data);
    if (dataObj['data'] == '') {
      return;
    }
    tc.print(message:data, endline: true);
    update();
    // textData.value = 'Último chip processado: ${chipData.athleteNumber}';
  }

  Future<String?> initializeAthleteManager() async {
    _startListen();
    update();
    return null;
  }

  void _startListen() {
    if (!listening.value) {
      _connectionController.connection
          ?.streamData()
          .subject
          .listen((data) async {
        await handleData(data);
      });
      listening.value = true;
    }
  }

  Future<void> showAlertError(String errorMessage) async {
    errorCallback?.call(errorMessage);
  }

  String get eventCode => _eventCode.value;

  Future<void> clear() async {
    _eventCode.value = '';
    athleteManagement = null;
    listening.value = false;
    await readersDB.clearHeader();
    update();
  }

  _handleConnectionStatus(ConnectionStatus status) {
    if (athleteManagement != null) {
      if (status == ConnectionStatus.connected) {
        _startListen();
      } else {
        listening.value = false;
      }
    }
  }

  Future<void> openFile() async {
    var baseFolder = FileUtils.pickFolder();
    if (baseFolder == null) {
      return;
    }
    _infoText.value = baseFolder.path;
    eventCodeController.text = baseFolder.path;

    var splash_receive = "${baseFolder.path}\\splash_receive.txt";
    var splash_send = "${baseFolder.path}\\splash_send.txt";
    fs = FileService(splash_send, splash_receive);
    _startListen();
    update();
  }

  @override
  void changeReceiveFile(String data) {
    Logger().d('Receive data Change $eventCode $data');
  }

  @override
  void changeSendFile(String data) {
    Logger().d('Send data Change $eventCode $data');
  }
}
