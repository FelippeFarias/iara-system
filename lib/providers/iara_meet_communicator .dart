import 'package:flenex/flenex.dart';
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

  Future<void>  handleResponse(String data) async  {
    var lines = data.split('\n');
    for (var line in lines) {
      if (line.startsWith('VERSION;')) {
        _handleVersionResponse(line);
        break;
      } else if (line.startsWith('DOWNLOAD EVENT;')) {
        _handleDownloadEventResponse(line,data);
      } else if (line.startsWith('SEND NAMES;')) {
        _handleSendNamesResponse(line);
      } else if (line.startsWith('SEND RESULTS;')) {
        _handleSendResultsResponse(line);
      } else if (line.startsWith('STATUS;')) {
        _handleStatusResponse(line);
      }
      // Adicionar mais condições conforme necessário
    }
  }

  Future<void> _handleDownloadEventResponse(String line,String data) async {
    try {
      Logger().d(await flenex.extractXml(data));
      var lenex = await flenex.parseStringXml(data);
      Logger().d(lenex);

      // Respostas possíveis: DOWNLOAD EVENT;OK, DOWNLOAD EVENT;ABORT, DOWNLOAD EVENT;BUSY
      if (line.contains('DOWNLOAD EVENT;OK')) {
        // Lógica para tratamento de evento baixado com sucesso
      } else if (line.contains('DOWNLOAD EVENT;ABORT')) {
        // Lógica para tratamento de evento abortado
      } else if (line.contains('DOWNLOAD EVENT;BUSY')) {
        // Lógica para tratamento de evento ocupado
      }
    } catch (e, stackTrace) {
      Logger().d(e,stackTrace: stackTrace);
    }
  }



  void _handleSendNamesResponse(String line) {
    // Início e fim da transmissão de nomes: SEND NAMES;START, SEND NAMES;END
    if (line.contains('SEND NAMES;START')) {
      // Lógica para iniciar o processamento de nomes
    } else if (line.contains('SEND NAMES;END')) {
      // Lógica para finalizar o processamento de nomes
    }
  }

  void _handleVersionResponse(String line) {
    sendInitializationMessage();
  }

  void _handleSendResultsResponse(String line) {
    // Respostas possíveis: SEND RESULTS;START, SEND RESULTS;END, SEND RESULTS;NOT FOUND
    if (line.contains('SEND RESULTS;START')) {
      // Lógica para iniciar o processamento de resultados
    } else if (line.contains('SEND RESULTS;END')) {
      // Lógica para finalizar o processamento de resultados
    } else if (line.contains('SEND RESULTS;NOT FOUND')) {
      // Lógica para tratamento de resultados não encontrados
    }
  }

  void _handleStatusResponse(String line) {
    // Exemplo: STATUS;EVENTID=123;HEATID=456;START
    // Lógica: Extrair informações de status e processar conforme necessário
  }

}
