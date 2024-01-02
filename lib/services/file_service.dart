import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/interfaces/connection_interface.dart';
import 'package:logger/logger.dart';
import 'package:watcher/watcher.dart';

import '../providers/iara_meet_communicator.dart';
import '../ui/screens/connection/controllers/connection_controller.dart';

class FileService extends ConnectionInterface{
  final String sendFilePath;
  final String receiveFilePath;
  final INVALID_FILE_ATTRIBUTES = -1;
  final infoConnectionText = "".obs;
  final rxData = Rx<dynamic>('');
  final detailsStr = "".obs;
  final connecting = false.obs;
  var status = ConnectionStatus.disconnected.obs;
  late IaraMeetCommunicator imc;
  final _connectionController = Get.find<ConnectionController>();

  FileService(this.sendFilePath, this.receiveFilePath) {_init();}

  Future<void> writeFile(String data, String filePath) async {
    var file = File(filePath);
    await file.writeAsString(data, mode: FileMode.writeOnly);
  }

  Future<String> readFile(String filePath) async {
    var file = File(filePath);
    return await file.readAsString();
  }

  Future<void> removeFile(String filePath) async {
    var file = File(filePath);
    await file.delete();
  }

  Future<void> _init() async {
    imc = IaraMeetCommunicator(this);
    _connectionController.connection = this;
    final watcher = FileWatcher(sendFilePath);
    final watcherReceiveFile = FileWatcher(receiveFilePath);
    watcherReceiveFile.events.listen((event) async  {
      if (event.type == ChangeType.MODIFY) {
        var value = await readFile(receiveFilePath);

      }
    });
    watcher.events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        var value = await readFile(sendFilePath);
        var event = await imc.handleResponse(value);
        if (event.type == 'version') {
          detailsStr.value = event.data;
        }

        onData(event );


      }
    });
    onConnected();
  }


  @override
  void onConnected() {
    status.value = ConnectionStatus.connected;
    infoConnectionText.value = "Conexão estabelecida.";
  }

  @override
  void onDisconnected() {
    infoConnectionText.value = "Conexão encerrada.";
    status.value =  ConnectionStatus.disconnected;
  }

  @override
  void onError(error) {
    infoConnectionText.value = "Erro na conexão: $error";
    status.value = ConnectionStatus.failed;
  }

  @override
  void onReconnecting(attempt) {
    status.value =  ConnectionStatus.disconnected;
    infoConnectionText.value = "Reconectando... Tentativa: $attempt";
  }

  @override
  void onData(dynamic data) {
    rxData.value  = data ;
  }

  @override
  ConnectionStatus getStatus() {
    return status.value;
  }

  @override
  Rx<dynamic> streamData() {
    return rxData;
  }

  @override
  String get details => detailsStr.value;

  @override
  String get name => 'File Service';


}
