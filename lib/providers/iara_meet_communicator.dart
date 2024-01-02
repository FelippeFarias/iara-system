import 'package:flenex/flenex.dart';
import 'package:iara/models/event_meet_manager.dart';
import 'package:iara/utils/file_utils.dart';
import 'package:logger/logger.dart';

import '../services/file_service.dart';

class IaraMeetCommunicator {

  final FileService fileService;
  final flenex = Flenex();

  IaraMeetCommunicator(this.fileService);

  // Método para enviar mensagens de inicialização e verificar status
  Future<void> sendInitializationMessage() async {
    String initMessage = 'VERSION;IARA System v1.0.0\n';
    await fileService.writeFile('', fileService.sendFilePath);
    await fileService.writeFile(initMessage, fileService.receiveFilePath);
  }


  // Método para iniciar o download de eventos
  void startEventDownload() {
    String startDownloadMessage = 'DOWNLOAD EVENT;START\n';
    _writeToSendFile(startDownloadMessage);
  }

  // Método para solicitar nomes
  void requestNames(int eventId, int heatId) {
    String requestNamesMessage = 'ASK NAMES;EVENTID=$eventId;HEATID=$heatId\n';
    _writeToSendFile(requestNamesMessage);
  }

  // Método para enviar resultados
  void sendResults(int eventId, int heatId, String resultsXml) {
    _writeToSendFile('SEND RESULTS;START\n');
    _writeToSendFile(resultsXml);
    _writeToSendFile('\nSEND RESULTS;END\n');
  }

  // Método para atualizar o status da corrida
  void updateRaceStatus(int eventId, int heatId, String status) {
    String statusMessage = 'STATUS;EVENTID=$eventId;HEATID=$heatId;$status\n';
    _writeToSendFile(statusMessage);
  }

  // Método para processar as respostas recebidas
  Future<String> processReceivedMessages() async {
    String receivedData = await fileService.readFile(fileService.receiveFilePath);
    return receivedData;
  }

  // Método auxiliar para escrever no arquivo de envio
  Future<void> _writeToSendFile(String message) async {
    await fileService.writeFile(message, fileService.sendFilePath);
  }

  Future<EventMeetMannager> handleResponse(String data) async  {
    var lines = data.split('\n');
    for (var line in lines) {
      if (line.startsWith('VERSION;')) {
        return await _handleVersionResponse(line);
      } else if (line.startsWith('DOWNLOAD EVENT;')) {
        return await _handleDownloadEventResponse(line,data);
      } else if (line.startsWith('SEND NAMES;')) {
        return await _handleSendNamesResponse(line,data);
      } else if (line.startsWith('SEND RESULTS;')) {
        return await  _handleSendResultsResponse(line,data);
      } else if (line.startsWith('STATUS;')) {
        return await  _handleStatusResponse(line,data);
      }else {
        return EventMeetMannager(type: 'error', data: 'Resposta desconhecida');
      }
      // Adicionar mais condições conforme necessário
    }
    return EventMeetMannager(type: 'error', data: 'Resposta desconhecida');
  }

  Future<EventMeetMannager> _handleDownloadEventResponse(String line,String data) async {
    try {

      var lenex = await flenex.read(data, 'text/xml');

      await fileService.writeFile('', fileService.sendFilePath);

      // Lógica para processar o evento
      // aqui dever ser realizado a verificação do status do modulo

      // Se o modulo de eventos estiver disponível, o evento será baixado
      // fileService.writeFile('DOWNLOAD EVENT;OK', fileService.receiveFilePath);

      // Se o modulo de eventos não estiver disponível, o evento não será baixado
      // fileService.writeFile('DOWNLOAD EVENT;ABORT', fileService.receiveFilePath);

      // Se o modulo de eventos estiver ocupado, o evento não será baixado
      // fileService.writeFile('DOWNLOAD EVENT;BUSY', fileService.receiveFilePath);

      fileService.writeFile('DOWNLOAD EVENT;OK', fileService.receiveFilePath);
      return EventMeetMannager(data:lenex, type: 'downloadEvent');
    } catch (e, stackTrace) {
      Logger().d(e,stackTrace: stackTrace);
      return EventMeetMannager( type: 'error', data: e.toString());
    }
  }



  Future<EventMeetMannager> _handleSendNamesResponse(String line,String data) async  {
    return EventMeetMannager(data: data, type: 'sendNames');
    // Início e fim da transmissão de nomes: SEND NAMES;START, SEND NAMES;END
    if (line.contains('SEND NAMES;START')) {
      // Lógica para iniciar o processamento de nomes
    } else if (line.contains('SEND NAMES;END')) {
      // Lógica para finalizar o processamento de nomes
    }
  }

  Future<EventMeetMannager> _handleVersionResponse(String line) async {
    String initMessage = 'VERSION;IARA System v1.0.0\n';
    await fileService.writeFile('', fileService.sendFilePath);
    await fileService.writeFile(initMessage, fileService.receiveFilePath);
    return  EventMeetMannager(data: line.trim().replaceAll('VERSION;', ''), type: 'version');
  }

  Future<EventMeetMannager> _handleSendResultsResponse(String line, String data) async {
    return EventMeetMannager(data: data, type: 'sendResults');
    // Respostas possíveis: SEND RESULTS;START, SEND RESULTS;END, SEND RESULTS;NOT FOUND
    if (line.contains('SEND RESULTS;START')) {
      // Lógica para iniciar o processamento de resultados
    } else if (line.contains('SEND RESULTS;END')) {
      // Lógica para finalizar o processamento de resultados
    } else if (line.contains('SEND RESULTS;NOT FOUND')) {
      // Lógica para tratamento de resultados não encontrados
    }
  }

  Future<EventMeetMannager  > _handleStatusResponse(String line ,String data) async {
    return EventMeetMannager(data: data, type: 'status');
    // Exemplo: STATUS;EVENTID=123;HEATID=456;START
    // Lógica: Extrair informações de status e processar conforme necessário
  }

}
