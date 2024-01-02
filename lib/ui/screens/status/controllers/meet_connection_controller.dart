import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iara/database/app_preferences.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/models/readers.dart';
import 'package:iara/providers/directories_controller.dart';
import 'package:iara/services/file_service.dart';
import 'package:iara/ui/screens/connection/controllers/connection_controller.dart';
import 'package:iara/utils/asset_paths.dart';
import 'package:iara/utils/constants.dart';
import 'package:iara/utils/convert_utils.dart';
import 'package:iara/utils/file_utils.dart';
import 'package:iara/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../database/readers_db_helper.dart';
import '../../../../interfaces/stream_files.dart';
import '../../../components/terminal_widget/flutter_console_controller.dart';

class MeetConnectionController extends GetxController {
  final eventCodeController = TextEditingController();
  final _infoText = ''.obs;
  final _chronDirectory = ''.obs;
  get infoText => _infoText.value;
  final listening = false.obs;
  final formKey = GlobalKey<FormState>();
  final _connectionController = Get.find<ConnectionController>();
  late final FileService? fs;
  final FlutterConsoleController tc = FlutterConsoleController();
  var rxData = Rx<dynamic>('');
  ConnectionStatus get status => _connectionController.status;
   Function(String)? errorCallback;

  @override
  void onInit() async {
    super.onInit();
    _connectionController.statusCallback = _handleConnectionStatus;
    _chronDirectory.value =   Get.find<AppPreferences>().getLocalData(key: Constants.KEY_DIR) ?? '';
    if (chronDirectory.isNotEmpty) {
      listening.value = false;
      _startListen();
    }

    eventCodeController.text =  _chronDirectory.value;
  }

  Future<void> handleData(dynamic data) async {
    if (data == null) {
      return;
    }
    rxData.value = data;
    tc.print(message: data.toString(), endline: true);
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

  String get chronDirectory => _chronDirectory.value;

  Future<void> clear() async {
    listening.value = false;
    update();
  }

  _handleConnectionStatus(ConnectionStatus status) {
    if (status == ConnectionStatus.connected) {
      _startListen();
    } else {
      listening.value = false;
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
    _chronDirectory.value = baseFolder.path;
    await Get.find<AppPreferences>().saveLocalData(key: Constants.KEY_DIR, data: baseFolder.path);
    _startListen();
    update();
  }


}
