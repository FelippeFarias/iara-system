import 'package:audioplayers/audioplayers.dart';
import 'package:iara/database/app_preferences.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/services/socket/socket_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../interfaces/connection_interface.dart';
import '../../../components/terminal_widget/flutter_console_controller.dart';
import '../../connection/controllers/connection_controller.dart';

class SocketController extends GetxController implements  ConnectionInterface {
  final infoConnectionText = "".obs;
  final textData = "".obs;
  final connecting = false.obs;
  var status = ConnectionStatus.disconnected.obs;
  final FlutterConsoleController tc = FlutterConsoleController();
  final _connectionController = Get.find<ConnectionController>();
  final edtIpController = TextEditingController(text: "");
  final edtPortController = TextEditingController(text: "");
  // Serviço de socket.
  SocketService? socketService;


  @override
  void onInit() {
    super.onInit();
    edtIpController.text = AppPreferences().getLocalData(key: 'ip') ?? "";
    edtPortController.text = AppPreferences().getLocalData(key: 'port') ?? "";
  } // Método para conectar o socket.
  Future<bool> connect(String ip, String port) async {
    connecting.value = true; // Indica que a conexão está em andamento.

    try {
      socketService = SocketService(host: ip, port: int.parse(port), callbacks: this);
      await socketService!.connect();
      status.value = socketService!.isConnected
          ? ConnectionStatus.connected // Conectado
          : ConnectionStatus.failed; // Falha na conexão

      AppPreferences().saveLocalData(key: 'ip', data: ip);
      AppPreferences().saveLocalData(key: 'port', data: port);

      _connectionController.connection = this;
    } catch (e) {
      status.value = ConnectionStatus.failed;
      infoConnectionText.value = "Erro ao conectar: $e"; // Atualiza o texto de informação com a exceção.
      tc.print(message: infoConnectionText.value, endline: true);

    } finally {
      connecting.value = false; // Indica que o processo de conexão terminou.
    }

    // Retorna o status da conexão.
    return socketService != null && socketService!.isConnected;
  }

  void disconnect() {
    socketService?.disconnect(); // Limpa o serviço de socket.
    _connectionController.connection = null;

  }

  @override
  void onConnected() {
    status.value = ConnectionStatus.connected;
    infoConnectionText.value = "Conexão estabelecida."; // Atualiza o texto de informação.
    tc.print(message: infoConnectionText.value, endline: true);
    update();

  }

  @override
  void onDisconnected() {
    infoConnectionText.value = "Conexão encerrada."; // Atualiza o texto de informação.
    tc.print(message: infoConnectionText.value, endline: true);
    status.value =  ConnectionStatus.disconnected;
  }

  @override
  void onError(error) {
    infoConnectionText.value = "Erro na conexão: $error"; // Atualiza o texto de informação com o erro.
    tc.print(message: infoConnectionText.value, endline: true);
    status.value = ConnectionStatus.failed;
  }

  @override
  void onReconnecting(attempt) {
    status.value =  ConnectionStatus.disconnected;
    infoConnectionText.value = "Reconectando... Tentativa: $attempt"; // Atualiza o texto de informação.
    tc.print(message: infoConnectionText.value, endline: true);
  }

  @override
  void onData(String data) {
    textData.value  = data.trim();
    tc.print(message: textData.value, endline: true);
  }

  @override
  ConnectionStatus getStatus() {
    return status.value;
  }

  @override
  RxString streamData() {
    return textData;
  }

  @override
  String get details => 'Ip: ${socketService?.host} | Porta: ${socketService?.port}';

  @override
  String get name => 'Conexão Socket';


}
