import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:iara/generated/assets.dart';
import 'package:iara/providers/console_manager.dart';
import 'package:dart_console/dart_console.dart';
import 'package:davi/davi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../intl/lang_constants.dart';
import '../../../models/athlete_item.dart';
import '../../../utils/theme.dart';
import '../../components/window_buttons.dart';
import '../base/base_screen.dart';
import '../home/controllers/home_controller.dart';

class StatusScreen extends StatefulWidget {
  @override
  StatusnState createState() => StatusnState();
}

class StatusnState extends State<StatusScreen> {
  final _appTheme = Get.find<AppTheme>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: WindowTitleBarBox(
          child: Row(
            children: <Widget>[
              MoveWindow(
                child: FooterConnectionInfo(),
              ).expand(),
              WindowButtons(
                showCloseButton: false,
                showMinimizeButton: false,
              )
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      content: Container(
        color: _appTheme.scaffoldBackgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: GetBuilder<HomeController>(builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Flex(direction: Axis.vertical, children: [
                              LangConstants.chipsToVerify.tr.text.bold.xl.make(),
                              "${controller.athleteManagement?.totalChipsToVerify ?? 0}"
                                  .text
                                  .xl4
                                  .make(),
                            ]).expand(),
                            Flex(direction: Axis.vertical, children: [
                              LangConstants.chipsVerified.tr.text.bold.xl.make(),
                              "${controller.athleteManagement?.chipsVerified ?? 0}"
                                  .text
                                  .xl4
                                  .make(),
                            ]).expand(),
                          ],
                        ),
                        10.heightBox,
                        DaviTheme(
                          data: _appTheme.daviThemeData,
                          child: Davi<AthleteItem>(
                            DaviModel(
                              rows: controller
                                  .athleteManagement?.listOnlyNotVerified
                                  .toList() ??
                                  [],
                              columns: [
                                DaviColumn(
                                    name: LangConstants.code.tr,
                                    headerTextStyle: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                    cellTextStyle: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                    grow: 1,
                                    stringValue: (row) => row.athleteNumber),
                              ],
                              alwaysSorted: true,
                            ),
                            rowColor: (row) =>
                            (row.data.status == 'error' ? Vx.red200 : null),
                          ),
                        ).expand().hide(
                            isVisible: controller.athleteManagement
                                ?.listOnlyNotVerified.isNotEmpty ??
                                false),
                        Column(
                          children: [
                            Lottie.asset(_appTheme.mode == ThemeMode.dark
                                ? Assets.imagesScanSuccessDark
                                : Assets.imagesScanSuccessLight,
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                              height: constraints.maxWidth > 900 ? 350:  200,
                            ),
                            LangConstants.chipsVerified.tr.text.xl3.bold.make(),
                            Text(
                              '${controller.athleteManagement?.chipsVerified ?? 0} ${LangConstants.successfullyVerified.tr}',
                            )
                          ],
                        ).hide(
                            isVisible: (controller.athleteManagement
                                ?.athleteList.isNotEmpty ??
                                false) && (controller.athleteManagement
                                ?.listOnlyNotVerified.isEmpty ??
                                false)),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
