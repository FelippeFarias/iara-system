
import 'package:iara/providers/console_manager.dart';
import 'package:dart_console/dart_console.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../intl/lang_constants.dart';
import '../../../services/socket/socket_service.dart';
import '../../../utils/theme.dart';
import '../../../utils/ui_utils.dart';
import '../../components/base_window.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final appTheme = Get.find<AppTheme>();
  final cm = ConsoleManager();
  final TextEditingController _codigoEventoController = TextEditingController();
  final TextEditingController _numeroInicialController =
  TextEditingController();
  final TextEditingController _numeroFinalController = TextEditingController();
   @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    return   BaseWindow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flex( direction: Axis.horizontal, children: [
            Expanded(
              child:
              InfoLabel(
                label: LangConstants.eventCode.tr,
                child: TextBox(
                  controller: _codigoEventoController,
                  placeholder: 'Ex: 123456',
                  readOnly: true,
                  placeholderStyle: TextStyle(color: appTheme.hintColor),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child:
              Container(),
            ),
          ],),

          SizedBox(height: 20),

          Row(children: <Widget>[
            Expanded(
              child:
              InfoLabel(
                label: 'Número Inicial do Chip',
                child: TextBox(
                  controller: _numeroInicialController,
                  placeholder: 'Ex: 123456',
                  placeholderStyle: TextStyle(color: appTheme.hintColor),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  readOnly: true,
                ),
              ),


            ),
            SizedBox(width: 20),
            Expanded(
              child:
              InfoLabel(
                label: 'Número Final do Chip',
                child: TextBox(
                  controller: _numeroFinalController,
                  placeholder: 'Ex: 123456',
                  keyboardType: TextInputType.number,
                  placeholderStyle: TextStyle(color: appTheme.hintColor),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),

            ),
          ]),


          SizedBox(height: 40),
          FilledButton(
            child: Text('Iniciar Verificação'),
            onPressed: () {
              // Lógica para iniciar o processo de verificação
              // Com base nos dados inseridos
            },
          ),
        ],
      ),
    );
  }
}
