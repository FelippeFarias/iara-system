import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';

import '../../interfaces/connection_interface.dart';

class SocketService {
  final String _host;
  final int _port;
  final ConnectionInterface callbacks;
  Socket? _socket;
   final int _maxReconnectionAttempts = 3;
  int _reconnectionAttempts = 0;
  bool isConnected = false;
  bool _isControllerClosed = false;


  String get host => _host;

  SocketService({required String host, required int port,required this.callbacks})
      : _host = host,
        _port = port;


  Future<void> connect() async {
    if (isConnected) {
      return;
    }

    try {
      _socket = await Socket.connect(_host, _port);
      isConnected = true;
      _isControllerClosed = false;  // Garantir que o estado do controlador esteja correto
      callbacks.onConnected();
      _reconnectionAttempts = 0;
      _socket!.listen((List<int> data) {
        if (!_isControllerClosed) {  // Verificar se o controlador está fechado
          callbacks.onData(String.fromCharCodes(data));
        }
      },
        onError: _handleError,
        onDone: _handleDone,
        cancelOnError: true,
      );
    } catch (e) {
      isConnected = false;
      _isControllerClosed = true;  // Atualizar o estado quando ocorre um erro
      callbacks.onError(e);
      _handleError(e);
    }
  }

  void send(String message) {
    if (isConnected && !_isControllerClosed) {
      _socket?.add(utf8.encode(message));
    } else {
      Logger().d('Socket not connected or controller closed, message not sent: $message');
    }
  }

  void _handleError(dynamic error) {
    if (!_isControllerClosed) {
      callbacks.onError(error);
    }
    callbacks.onError(error);

    if (isConnected || _reconnectionAttempts > 0) {
      isConnected = false;
      _reconnect();
    }
  }

  void _handleDone() {
    callbacks.onDisconnected();
    if (isConnected || _reconnectionAttempts > 0) {
      isConnected = false;
      _reconnect();
    }
  }

  void _reconnect() {
    if (_reconnectionAttempts >= _maxReconnectionAttempts) {
      Logger().d('Max reconnection attempts reached. Not attempting further.');
      disconnect();
      return;
    }

    _reconnectionAttempts++;
    Logger().d('Attempting to reconnect to the socket... Attempt: $_reconnectionAttempts');
    callbacks.onReconnecting(_reconnectionAttempts);
    Future.delayed(const Duration(seconds: 2), () {
      connect();
    });
  }

  void disconnect() {
    _socket?.close();
    if (!_isControllerClosed) {
      callbacks.onDisconnected();
      _isControllerClosed = true;
    }
    isConnected = false;
    callbacks.onDisconnected();
  }

  int get port => _port;
}
