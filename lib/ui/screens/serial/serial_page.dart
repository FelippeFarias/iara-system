import 'dart:math';

import 'package:iara/enum/connection_status.dart';
import 'package:iara/ui/screens/serial/controllers/serial_controller.dart';
import 'package:iara/ui/screens/socket/controllers/socket_controller.dart';
import 'package:iara/utils/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/asset_paths.dart';
import '../../../utils/ip_formatter.dart';
import '../../components/base_window.dart';
import '../../components/form_field.dart';
import '../../components/terminal_widget/flutter_console.dart';

class SerialPage extends StatefulWidget {
  @override
  _SerialPageState createState() => _SerialPageState();
}

class _SerialPageState extends State<SerialPage> {
  final _controller = Get.find<SerialController>();
  final tsc = ScrollController();
  final _formKey = GlobalKey<FormState>(); // Adicionado para validação

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            AssetPaths.socketImage,
            height: 500,
          ),
        ).opacity(value: .03),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget>[
                  // Seus primeiros três widgets
                  SizedBox(

                    child: InfoLabel(
                      label: 'Port',
                      child: ComboBox<String>(
                        value: _controller.port,
                        items: _controller.avaliablePorts.map<ComboBoxItem<String>>((e) {
                          return ComboBoxItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() => _controller.setPort(item ?? ''));
                        },

                      ),
                    ),
                  ) ,
                  SizedBox(
                    child: InfoLabel(
                      label: 'Baud Rate',
                      child: ComboBox<String>(
                        value: _controller.baud,
                        items: _controller.baudRateList.map<ComboBoxItem<String>>((e) {
                          return ComboBoxItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() => _controller.setBaud(item ?? ''));
                        },

                      ),
                    ),
                  ),
                  SizedBox(
                    child: InfoLabel(
                      label: 'Data Size',
                      child: ComboBox<String>(
                        value: _controller.data_size,
                        items: _controller.dataSizeList.map<ComboBoxItem<String>>((e) {
                          return ComboBoxItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() => _controller.setDataSize(item ?? ''));
                        },

                      ),
                    ),
                  ),
                  SizedBox(
                    child: InfoLabel(
                      label: 'Stop Bits',
                      child: ComboBox<String>(
                        value: _controller.stop_bits,
                        items: _controller.stopBitsList.map<ComboBoxItem<String>>((e) {
                          return ComboBoxItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() => _controller.setStopBits(item ?? ''));
                        },

                      ),
                    ),
                  ),
                  SizedBox(
                    child: InfoLabel(
                      label: 'Parity',
                      child: ComboBox<String>(
                        value: _controller.parity,
                        items: _controller.parityList.map<ComboBoxItem<String>>((e) {
                          return ComboBoxItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() => _controller.setParity(item ?? ''));
                        },
                      ),
                    ),
                  ),

                ],
              ),
              20.heightBox,
              Obx(() {
                return FilledButton(
                  onPressed: _controller.connecting.isFalse
                      ? () async {
                    if (_controller.status.value ==
                        ConnectionStatus.connected) {
                      // Se já estiver conectado, desconectar
                      _controller.disconnect();
                    } else {
                      var connected = await _controller.openPort( );
                      if (!connected) {
                        if (mounted) {
                          showContentDialog(context);
                        }
                      }
                    }
                  }
                      : null,
                  child: _controller.connecting.isFalse
                      ? (_controller.status.value == ConnectionStatus.connected
                      ? 'Desconectar'.text.makeCentered()
                      : 'Conectar'
                      .text
                      .makeCentered()) // Texto do botão baseado no status da conexão
                      : SpinKitThreeBounce(size: 25, color: Get.find<AppTheme>().color,), // Desabilita o botão quando está conectando
                );
              }),
              16.heightBox,
              Expander(
                leading: Icon(FluentIcons.power_shell ,size: 16),
                header: "Terminal".text.base.make(),
                content: FlutterConsole(
                  showInput: false,
                  controller: _controller.tc,
                  height: 180,
                  width: context.width,
                ),
              )
              // Mensagem de status
            ],
          ),
        )
      ],
    );
  }



  /// Creates a tab for the given index

  Widget buildTerminalWidget() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F2A),
        borderRadius: BorderRadius.circular(10.0), // roundedLg
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: _controller.textData.string.text.sm
              .color(
                const Color(0xFFF1A700),
              )
              .make(),
        ),
      ),
    );
  }

  void showContentDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Erro'),
        content: Text(_controller.infoConnectionText.value),
        // Conteúdo baseado na mensagem de erro
        actions: [
          FilledButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.pop(context, 'Usuário fechou o dialog'),
          ),
        ],
      ),
    );

    // Aqui você pode tratar a resposta do dialog se necessário
    if (result == 'Usuário fechou o dialog') {
      // Ação se o usuário fechar o dialog
    }
  }

  String? _validateIpAddress(String? value) {
    if (value == null || !RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(value)) {
      return 'Digite um IP válido.';
    }
    return null;
  }

  String? _validatePort(String? value) {
    if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
      return 'Digite uma porta válida.';
    }
    return null;
  }
}
