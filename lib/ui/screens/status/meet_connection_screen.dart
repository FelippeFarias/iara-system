import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iara/ui/screens/home/controllers/home_controller.dart';
import 'package:iara/ui/screens/status/controllers/meet_connection_controller.dart';
import 'package:iara/utils/fixed_length_input_formatter.dart';
import 'package:iara/utils/theme.dart';
import 'package:iara/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../intl/lang_constants.dart';
import '../../../utils/asset_paths.dart';
import '../../components/form_field.dart';
import '../../components/terminal_widget/flutter_console.dart';

class MeetConnectionPage extends StatefulWidget {
  @override
  _MeetConnectionPageState createState() => _MeetConnectionPageState();
}

class _MeetConnectionPageState extends State<MeetConnectionPage> {
  final _controller = Get.find<MeetConnectionController>();
  final _appTheme = Get.find<AppTheme>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.errorCallback = showAlertError;
  }

  Future<void> showAlertError(String errorMessage) async {
    await displayInfoBar(context, builder: (context, close) {
       return InfoBar(
        title: Text(LangConstants.error.tr),
        content: Text(errorMessage),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: InfoBarSeverity.error,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 600;
            return Form(
                key: formKey,
                child: GetBuilder<HomeController>(
                  builder: (_) {
                    return Column(
                      children: <Widget>[
                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // Espaçamento vertical entre as linhas
                          children: <Widget>[
                            // Seus primeiros três widgets
                            SizedBox(
                              height: 56,
                              child: CustomTextFormBox(
                                label: 'Diretório de Cronometragem',
                                controller: _controller.eventCodeController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FixedLengthInputFormatter()
                                ],
                              ),
                            ).expand(),

                            10.widthBox,
                            // Quebra a linha em telas pequenas
                            SizedBox(
                                height: 32,
                                child:  FilledButton(
                                  onPressed: ()=> _controller.openFile(),
                                  child: 'Selecionar Pasta'.text.make(),
                                )).paddingOnly(top: isLargeScreen ? 24 : 0) ,
                          ],
                        ),
                        20.heightBox,
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

                      ],
                    );
                  },
                ));
          },
        ).expand(),

        // Adicione outros widgets conforme necessário
      ],
    );
  }



  String? _validateEventCode() {
    String value = _controller.eventCodeController.text;
    if (value.isEmpty || value == '00000') {
      return LangConstants.eventCodeIsRequired.tr;
    }
    if (value.length != 5 || !value.isNumericOnly) {
      return LangConstants.eventCodeMustBe5Digits.tr;
    }
    return null; // retorna null se a validação passar
  }


}

