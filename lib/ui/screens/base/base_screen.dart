import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:iara/enum/connection_status.dart';
import 'package:iara/intl/Lang.dart';
import 'package:iara/intl/lang_constants.dart';
import 'package:iara/services/theme_service.dart';
import 'package:iara/ui/screens/base/controllers/base_controller.dart';
import 'package:iara/ui/screens/socket/controllers/socket_controller.dart';
import 'package:iara/ui/screens/socket/socket_page.dart';
import 'package:iara/utils/asset_paths.dart';
import 'package:iara/utils/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../generated/assets.dart';
import '../../components/window_buttons.dart';
import '../connection/connection_page.dart';
import '../connection/controllers/connection_controller.dart';
import '../home/home_page.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final _connection = Get.find<ConnectionController>();
  final _appTheme = Get.find<AppTheme>();
  final _controller = Get.find<BaseController>();
  PaneDisplayMode displayMode = PaneDisplayMode.open;
  String pageTransition = 'Default';
  static const List<String> pageTransitions = [
    'Default',
    'Entrance',
    'Drill in',
    'Horizontal',
  ];
  String indicator = 'Sticky';

  @override
  Widget build(BuildContext context) {
    return Material.Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        return GetBuilder<BaseController>(builder: (logic) {
          return NavigationView(
            appBar: NavigationAppBar(
              automaticallyImplyLeading: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MoveWindow(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        SvgPicture.asset(
                          AssetPaths.logo_name,

                          height: 30,
                          colorFilter: ColorFilter.mode(
                              _appTheme.color, BlendMode.srcIn),
                        )
                      ],
                    ).hide(isVisible: constraints.maxWidth < 900),
                  ).expand(),
                  WindowButtons()
                ],
              ),
            ),
            pane: NavigationPane(
              header: Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AssetPaths.logo_name,
                      height: 80,
                      colorFilter:
                          ColorFilter.mode(_appTheme.color, BlendMode.srcIn),
                    ),
                    4.heightBox,
                    'v1.0.0'.text.sm.make()
                  ],
                ),
              ).hide(isVisible: constraints.maxWidth > 900),
              selected: _controller.topIndex,
              onChanged: (index) => _controller.navigatTo(index),
              // displayMode:  PaneDisplayMode.open,
              displayMode: constraints.maxWidth < 900
                  ? PaneDisplayMode.compact
                  : PaneDisplayMode.open,
              items: [
                PaneItemSeparator(),
                PaneItem(
                  icon: const Icon(FluentIcons.generic_scan),
                  title:   Text(LangConstants.home.tr),
                  body: _NavigationBodyItem(
                    header: LangConstants.home.tr,
                    content: HomePage(),
                  ),
                ),
                PaneItemSeparator(),
                PaneItem(
                  icon: const Icon(FluentIcons.plug_connected),
                  title:   Text( LangConstants.connections.tr,),
                  infoBadge: Obx(() {
                    return InfoBadge(
                        source: Icon(
                            (_connection.status == ConnectionStatus.connected)
                                ? FluentIcons.check_mark
                                : FluentIcons.plug_disconnected),
                        color:
                            (_connection.status == ConnectionStatus.connected)
                                ? Colors.green
                                : Colors.red);
                  }),
                  body: _NavigationBodyItem(content: ConnectionPage()),
                ),
                PaneItemSeparator(),
                PaneItemAction(
                    icon: const Icon(FluentIcons.locale_language),
                    title: Text(LangConstants.language.tr),
                    onTap: () async {
                      await showDialog<String>(
                        context: context,
                        builder: (context) => ContentDialog(
                          title: Text(LangConstants.chooseLanguage.tr),
                          content: ListView(
                            shrinkWrap: true,
                            children: [
                              RadioButton(
                                  content: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.iconsIcFlagUnitedStates,
                                          height: 24,
                                        ),
                                        10.widthBox,
                                        LangConstants.english.tr.text.make(),
                                      ]),
                                  checked: Lang().languageCode() == 'en',
                                  onChanged: (value) async {
                                    await showAlertError();
                                    // if (value) {
                                    //   await Lang()
                                    //       .setLocale(const Locale('en', 'US'));
                                    //
                                    // }
                                    if (mounted) {
                                      Navigator.pop(context);
                                    }
                                  }),
                              10.heightBox,
                              RadioButton(
                                  content: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.iconsIcFlagBrazil,
                                          height: 24,
                                        ),
                                        10.widthBox,
                                        LangConstants.portuguese.tr.text.make(),
                                      ]),
                                  checked: Lang().languageCode() == 'pt',
                                  onChanged: (value) async {
                                    if (value) {
                                      await Lang()
                                          .setLocale(const Locale('pt', 'BR'));

                                    }if (mounted) {
                                      Navigator.pop(context);
                                    }
                                  }),

                              10.heightBox,
                              RadioButton(
                                  content: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.iconsIcFlagSpan,
                                          height: 24,
                                        ),
                                        10.widthBox,
                                        LangConstants.spanish.tr.text.make(),
                                      ]),
                                  checked: Lang().languageCode() == 'es',
                                  onChanged: (value) async {
                                    await showAlertError();
                                    /*if (value) {
                                      await Lang()
                                          .setLocale(const Locale('es', 'ES'));

                                    }*/
                                    if (mounted) {
                                      Navigator.pop(context);
                                    }
                                  }),
                              10.heightBox,
                            ],
                          ),
                        ),
                      );
                    }),
                PaneItemSeparator(),
                PaneItemAction(
                    icon: const Icon(FluentIcons.color),
                    title: Text(LangConstants.theme.tr),
                    onTap: () async {
                      await showDialog<String>(
                        context: context,
                        builder: (context) => ContentDialog(
                          title: Text(LangConstants.chooseTheme.tr),
                          content: ListView(
                            shrinkWrap: true,
                            children: [
                              RadioButton(
                                  content:   Text(LangConstants.light.tr),
                                  checked: _appTheme.mode == ThemeMode.light,
                                  onChanged: (value) {
                                    _appTheme
                                        .switchTheme(ThemeService.LIGHT_MODE);
                                    Navigator.pop(context);
                                  }),
                              10.heightBox,
                              RadioButton(
                                  content: Text(LangConstants.dark.tr),
                                  checked: _appTheme.mode == ThemeMode.dark,
                                  onChanged: (value) {
                                    _appTheme
                                        .switchTheme(ThemeService.DARK_MODE);
                                    Navigator.pop(context);
                                  }),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
            transitionBuilder: pageTransition == 'Default'
                ? null
                : (child, animation) {
                    switch (pageTransition) {
                      case 'Entrance':
                        return EntrancePageTransition(
                          animation: animation,
                          child: child,
                        );
                      case 'Drill in':
                        return DrillInPageTransition(
                          animation: animation,
                          child: child,
                        );
                      case 'Horizontal':
                        return HorizontalSlidePageTransition(
                          animation: animation,
                          child: child,
                        );
                      default:
                        throw UnsupportedError(
                          '$pageTransition is not a supported transition',
                        );
                    }
                  },
          );
        });
      },
    ));
  }
  Future<void> showAlertError() async {
    await displayInfoBar(context, builder: (context, close) {
      return InfoBar(
        title: Text('Em Construção'),
        content: Text('Tradução em endamento.'),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: InfoBarSeverity.info,
      );
    });
  }

}

class FooterConnectionInfo extends StatelessWidget {
  FooterConnectionInfo({
    super.key,
  });

  final ConnectionController _connection = Get.find<ConnectionController>();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Get.find<AppTheme>().cardColor,
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return Center(
          child: Row(
            children: <Widget>[
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  "${LangConstants.status.tr}${_connection.status.humanizedName} ".text.sm.make(),
                  SpinKitDoubleBounce( size: 10, color: _connection.status == ConnectionStatus.connected
                      ? Colors.green
                      : Colors.red,),

                ],
              ),
              10.widthBox,
              '|'.text.sm.color(Get.find<AppTheme>().hintColor).make(),
              10.widthBox,
              "${LangConstants.type.tr}${_connection.connection?.name} ".text.sm.make(),
              10.widthBox,
              '|'.text.sm.color(Get.find<AppTheme>().hintColor).make(),
              10.widthBox,
              "${LangConstants.details.tr}${_connection.connection?.details} "
                  .text
                  .sm
                  .make() ,
            ],
          ),
        );
      }),
    );
  }
}

class _NavigationBodyItem extends StatelessWidget {
  const _NavigationBodyItem({
    this.header,
    this.content,
    this.footerInfoContent = true,
  });

  final String? header;
  final Widget? content;
  final bool footerInfoContent;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppTheme>(builder: (themeCtrl) {
      return Container(
        color: themeCtrl.scaffoldBackgroundColor,
        child: ScaffoldPage.withPadding(
          header: header != null
              ? PageHeader(title: Text(header ?? 'This is a header text'))
              : null,
          content: content ?? const SizedBox.shrink(),
          bottomBar: footerInfoContent ? FooterConnectionInfo() : null,
        ),
      );
    });
  }
}
