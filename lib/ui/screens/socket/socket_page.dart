import 'dart:math';

import 'package:iara/enum/connection_status.dart';
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

class SocketPage extends StatefulWidget {
  @override
  _SocketPageState createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {

  final _controller = Get.find<SocketController>();
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
        LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 10, // Espaçamento horizontal entre os widgets
                  runSpacing: 10, // Espaçamento vertical entre as linhas
                  children: <Widget>[
                    // Seus primeiros três widgets
                    SizedBox(
                      width: (constraints.maxWidth /
                          (!isLargeScreen ? 2 : 3)) - 10,
                      child: CustomTextFormBox(
                        label: 'Host',
                        placeholder: '127.0.0.1',
                        validator: (value) => _validateIpAddress(value),
                        controller: _controller.edtIpController,

                      ),
                    ),
                    SizedBox(
                      width: (constraints.maxWidth /
                          (!isLargeScreen ? 2 : 3)) -
                          10,
                      child: CustomTextFormBox(
                        label: 'Porta',
                        placeholder: '10200',
                        validator: (value) => _validatePort(value),
                        controller: _controller.edtPortController,
                        keyboardType: TextInputType.number,
                        errorHighlightColor: Vx.blue800,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),

                    // O botão que pode ou não quebrar para a próxima linha
                    if (!isLargeScreen)
                      Container(width: constraints.maxWidth),

                    // Quebra a linha em telas pequenas
                    SizedBox(
                      height: 32,
                      width: isLargeScreen
                          ? (constraints.maxWidth / 3) - 10
                          : double.infinity,
                      child:    Obx(() {
                        return FilledButton(
                          onPressed: _controller.connecting.isFalse
                              ? () async {
                            if (_controller.status.value ==
                                ConnectionStatus.connected) {
                              // Se já estiver conectado, desconectar
                              _controller.disconnect();
                            } else {
                              // Se estiver desconectado, tentar conectar
                              if (_formKey.currentState!.validate()) {
                                var connected = await _controller.connect(
                                    _controller.edtIpController.text,
                                    _controller.edtPortController.text);
                                if (!connected) {
                                  // Se não conseguir conectar, mostrar o ContentDialog
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
                    ).paddingOnly(top: isLargeScreen ? 24 : 0),
                  ],
                ),

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
          );
        },
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
