import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:iara/enum/parity.dart';
import 'package:iara/enum/serial_baud.dart';
import 'package:iara/utils/convert_utils.dart';
import 'package:logger/logger.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'package:win32/win32.dart';

import '../../interfaces/connection_interface.dart';

class UsbService {
  SerialPort? _serialPort;
  static const int _reconnectionAttempts = 3;
  int _currentAttempt = 0;
  bool _isConnected = false;
  bool _firstCreated = false;
  final ConnectionInterface _callbacks;
  StringBuffer _buffer = StringBuffer();
  bool _isControllerClosed = false;

  List<String> get availablePorts => SerialPort.getAvailablePorts();

  bool get isConnected => _isConnected;

  UsbService(this._callbacks);

  Future<bool> openPort(String portName,
      {int baudRate = 9600, int parity = 0, int stopBits = 0, int data_size = 0}) async {

    _serialPort = SerialPort(portName,
        openNow: false,
        BaudRate: baudRate,
        Parity: parity,
        ByteSize : data_size,
        StopBits: _getStopBits(stopBits),
        ReadIntervalTimeout: 1,
        ReadTotalTimeoutConstant: 2);
    try {
      _serialPort!.open();
      _serialPort!.BaudRate = baudRate;
      _serialPort!.Parity = parity;
      _serialPort!.ByteSize = data_size;
      _serialPort!.StopBits = _getStopBits(stopBits);
      _isControllerClosed = false;
      // final uint8_data = Uint8List.fromList([10, 127, 4 ,37 ,10 ,1, 67]);
      // writeUint8List( uint8_data );
      _updateConnectionStatus(_serialPort!.isOpened);
      if (!_firstCreated) {
        _readData();
      }

      return _serialPort!.isOpened;
    } catch (e) {
      _handleConnectionError(e, portName);
      return false;
    }
  }

  void _readData() {
    _serialPort?.readBytesOnListen(24, _processData);
    _firstCreated = true;
  }

  void _processData(Uint8List value) {
    try {
      _buffer.write(String.fromCharCodes(value));
      String bufferString;
      while ((bufferString = _buffer.toString()).contains('\n')) {
        int endIndex = bufferString.indexOf('\n') + 1;
        String completeMessage = bufferString.substring(0, endIndex);
        _callbacks.onData(completeMessage);
        _buffer = StringBuffer(bufferString.substring(endIndex));
      }
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  void writeString(String data) =>
      _writeData(() => _serialPort?.writeBytesFromString(data));

  void writeUint8List(Uint8List data) =>
      _writeData(() => _serialPort?.writeBytesFromUint8List(data));

  void _writeData(VoidCallback action) {
    try {
      action();
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  void disconnect() {
    if (_serialPort?.isOpened ?? false) {
      _serialPort!.closeOnListen(onListen: _onPortClosed)
        ..onError(print)
        ..onDone(_onDisconnectDone);
    }
  }

  void _onPortClosed() => () {};

  void _onDisconnectDone() {
    if (!_isControllerClosed) {
      _isControllerClosed = true;
      _serialPort = null;
    }
    _updateConnectionStatus(false);
  }

  void _reconnect() {
    if (_currentAttempt < _reconnectionAttempts) {
      _currentAttempt++;
      Logger().d(
          "Tentando reconectar... Tentativa $_currentAttempt de $_reconnectionAttempts");
      Timer(Duration(seconds: 5), () {
        if (!_isConnected) {
          openPort(_serialPort!.portName);
        }
      });
    } else {
      Logger().d("Falha ao reconectar após $_reconnectionAttempts tentativas.");
      _callbacks.onReconnecting(_reconnectionAttempts);
    }
  }

  void _updateConnectionStatus(bool status) {
    _isConnected = status;
    status ? _callbacks.onConnected() : _callbacks.onDisconnected();
  }

  void _handleConnectionError(dynamic error, [String? portName]) {
    if (!_isControllerClosed) {
      _callbacks.onError("Erro ao operar a porta serial: $error");
      if (isConnected || _reconnectionAttempts > 0) {
        _updateConnectionStatus(false);
        _reconnect();
      }
      return;
    }
    Logger().d(
        "Erro ao operar a porta serial:${portName != null ? '$portName ' : ''}$error");

  }

  int _getStopBits(int stopBits) => stopBits == 1 ? ONESTOPBIT : TWOSTOPBITS;

  List<String> getBaudRateList() =>
      SerialBaud.values.map((e) => e.value.toString()).toList();

  List<String> getParityList() =>
      Parity.values.map((e) => e.humanizedName).toList();

  List<String> getDataSizeList() =>
      [5, 6, 7, 8].map((e) => e.toString()).toList();

  List<String> getStopBitsList() => [1, 2].map((e) => e.toString()).toList();

  List<String> getAvailablePorts() => SerialPort.getAvailablePorts();
}
