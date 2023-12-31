import 'package:audioplayers/audioplayers.dart';
import 'package:iara/routers/routers.dart';
import 'package:iara/ui/screens/home/controllers/home_controller.dart';
import 'package:iara/utils/fixed_length_input_formatter.dart';
import 'package:iara/utils/theme.dart';
import 'package:iara/utils/utils.dart';
import 'package:davi/davi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../enum/connection_status.dart';
import '../../../generated/assets.dart';
import '../../../intl/lang_constants.dart';
import '../../../models/athlete_item.dart';
import '../../../utils/asset_paths.dart';
import '../../components/form_field.dart';
import '../../components/terminal_widget/flutter_console.dart';
import '../base/controllers/base_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.find<HomeController>();
  final _appTheme = Get.find<AppTheme>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.errorCallback = showAlertError;
  }

  Future<void> showAlertError(String errorMessage) async {
    await displayInfoBar(context, builder: (context, close) {
      _controller.player.play(AssetSource(AssetPaths.sound_alarm));
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
                                validator: (value) => _validateEventCode(),
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

  Future<void> _startProcessing() async {
    final String eventCode = _controller.eventCodeController.text;
    _controller.eventCode = eventCode;
    var result = await _controller.initializeAthleteManager( );
    if (result != null) {
      showSnack(
          title: LangConstants.error.tr, message: result, color: Vx.red600);
    }
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

  String? _validateNumber(TextEditingController controller,
      {String fieldName = ''}) {
    String value = controller.text;

    if (value.isEmpty || value == '00000') {
      return LangConstants.numberIsRequired.trParams({'fieldName': fieldName});
    }
    if (value.length != 5 || !value.isNumericOnly) {
      return LangConstants.numberMustBe5Digits
          .trParams({'fieldName': fieldName});
    }
    return null; // Retorna null se a validação passar
  }

  String? _validateChipNumberStart() {
    var string = _validateNumber(_controller.chipStartNumberController,
        fieldName: LangConstants.initialNumberLabel.tr);
    return string; // Retorna null ou a string de erro
  }

  String? _validateChipNumberEnd() {
    String startValue = _controller.chipStartNumberController.text;
    String endValue = _controller.chipEndNumberController.text;
    var string = _validateNumber(_controller.chipEndNumberController,
        fieldName: LangConstants.finalNumberLabel.tr);

    if (string == null && int.parse(startValue) >= int.parse(endValue)) {
      string = LangConstants.finalNumberMustBeGreaterThanInitial.tr;
    }
    return string; // Retorna null ou a string de erro
  }
}

// Inclua outras classes ou widgets auxiliares conforme necessário
