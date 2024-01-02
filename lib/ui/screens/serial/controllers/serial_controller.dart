import 'dart:async';

import 'package:iara/enum/parity.dart';
import 'package:iara/services/serial_usb/usb_service.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/services/socket/socket_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../interfaces/connection_interface.dart';
import '../../../components/terminal_widget/flutter_console_controller.dart';
import '../../connection/controllers/connection_controller.dart';

class SerialController extends GetxController implements ConnectionInterface {
  // Observáveis para armazenar informações e estado de conexão.
  final infoConnectionText = "".obs;
  final textData = "".obs;
  final _port = "COM1".obs;
  final _baud = "9600".obs;
  final _parity = "None".obs;
  final _data_size = "8".obs;
  final _stop_bits = "1".obs;
  final _avaliablePorts = RxList<String>([]);
  final _baudRateList = RxList<String>([]);
  final _parityList = RxList<String>([]);
  final _dataSizeList = RxList<String>([]);
  final _stopBitsList = RxList<String>([]);
  final _connectionController = Get.find<ConnectionController>();

  get port => _port.value;

  get baud => _baud.value;

  get parity => _parity.value;

  get stop_bits => _stop_bits.value;

  get data_size => _data_size.value;

  get baudRateList => _baudRateList;

  get parityList => _parityList;

  get dataSizeList => _dataSizeList;

  get stopBitsList => _stopBitsList;

  get avaliablePorts => _avaliablePorts.value;
  final connecting = false.obs;

  setPort(String value) => _port.value = value;

  setBaud(String value) => _baud.value = value;

  setParity(String value) => _parity.value = value;

  setDataSize(String value) => _data_size.value = value;

  setStopBits(String value) => _stop_bits.value = value;

  var status = ConnectionStatus.disconnected.obs;
  final FlutterConsoleController tc = FlutterConsoleController();

  // Serviço de socket.
  UsbService? usbService;

  @override
  void onInit() async {
    usbService = UsbService(this);
    _avaliablePorts.value = usbService!.getAvailablePorts();
    _baudRateList.value = usbService!.getBaudRateList();
    _parityList.value = usbService!.getParityList();
    _dataSizeList.value = usbService!.getDataSizeList();
    _stopBitsList.value = usbService!.getStopBitsList();
    if (_avaliablePorts.isNotEmpty) {
      _port.value = _avaliablePorts.first;
    }
    super.onInit();
  }

  // Método para conectar o socket.
  Future<bool> openPort() async {
    connecting.value = true; // Indica que a conexão está em andamento.

    try {
      await usbService!.openPort(
        _port.value,
        baudRate: int.parse(_baud.value),
        parity: ParityExtension.fromName(parity),
        stopBits: int.parse(stop_bits),
        data_size: int.parse(data_size),
      );
      status.value = usbService!.isConnected
          ? ConnectionStatus.connected // Conectado
          : ConnectionStatus.failed; // Falha na conexão

      _connectionController.connection = this;

    } catch (e) {
      status.value = ConnectionStatus.failed;
      infoConnectionText.value =
          "Erro ao conectar: $e"; // Atualiza o texto de informação com a exceção.
      tc.print(message: infoConnectionText.value, endline: true);
    } finally {
      connecting.value = false; // Indica que o processo de conexão terminou.
    }

    // Retorna o status da conexão.
    return usbService != null && usbService!.isConnected;
  }

  void disconnect() {
    usbService?.disconnect();
    _connectionController.connection = this;

  }
  @override
  void onData(dynamic data) {
    textData.value = data.trim();
    tc.print(message: textData.value, endline: true);
  }
  @override
  void onConnected() {
    status.value = ConnectionStatus.connected;
    infoConnectionText.value =
        "Conexão estabelecida."; // Atualiza o texto de informação.
    tc.print(message: infoConnectionText.value, endline: true);
  }

  @override
  void onDisconnected() {
    infoConnectionText.value =
        "Conexão encerrada."; // Atualiza o texto de informação.
    tc.print(message: infoConnectionText.value, endline: true);
    status.value = ConnectionStatus.disconnected;
  }

  @override
  void onError(error) {
    infoConnectionText.value =
        "Erro na conexão: $error"; // Atualiza o texto de informação com o erro.
    tc.print(message: infoConnectionText.value, endline: true);
    status.value = ConnectionStatus.failed;
  }

  @override
  void onReconnecting(attempt) {
    status.value = ConnectionStatus.disconnected;
    infoConnectionText.value =
        "Reconectando... Tentativa: $attempt"; // Atualiza o texto de informação.
    tc.print(message: infoConnectionText.value, endline: true);
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
  String get details => status.value == ConnectionStatus.connected?
  'Porta: ${port} ${baud},${data_size},${parity.substring(0, 1).toUpperCase()},${stop_bits}': 'null';

  @override
  String get name => 'Usb Serial';

}
