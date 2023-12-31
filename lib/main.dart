 import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iara/database/app_preferences.dart';
import 'package:iara/database/isar_db.dart';
import 'package:iara/services/theme_service.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import 'intl/Lang.dart';
import 'providers/directories_controller.dart';
import 'routers/routers.dart';
import 'utils/theme.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowsSingleInstance.ensureSingleInstance(
      args,
      "custom_identifier",
      onSecondWindow: (args) {
        print(args);
      });
  await _initConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var appThemeCtrl = Get.find<AppTheme>();
    return GetMaterialApp(
      translations: Lang(),
      locale: Lang().locale(),
      builder: (context, child) {

        return AnimatedFluentTheme(
          data: FluentThemeData(
            cardColor: appThemeCtrl.cardColor,
            scaffoldBackgroundColor: appThemeCtrl.scaffoldBackgroundColor,
            buttonTheme:  ButtonThemeData(
                filledButtonStyle:  ButtonStyle(
                    backgroundColor: ButtonState.resolveWith((states) {
                      if (states.isHovering) {
                        return appThemeCtrl.color.withOpacity(.6);
                      }
                      return appThemeCtrl.color;
                    }),
                    foregroundColor: ButtonState.resolveWith((states) => Colors.white)
                )
            ),
            accentColor: appThemeCtrl.color,
            navigationPaneTheme: NavigationPaneThemeData(
              backgroundColor: appThemeCtrl.cardColor,
              overlayBackgroundColor:  appThemeCtrl.cardColor,
            ),
            resources: appThemeCtrl.mode == ThemeMode.dark? ResourceDictionary.dark(
                solidBackgroundFillColorTertiary: appThemeCtrl.cardColor
            ):
            ResourceDictionary.light(
                solidBackgroundFillColorTertiary: appThemeCtrl.cardColor
            ),
            tooltipTheme: TooltipThemeData(
                textStyle: Material.Theme.of(context).textTheme.bodySmall,
                decoration: BoxDecoration(
                  color: appThemeCtrl.cardColor,
                  borderRadius: BorderRadius.circular(8),
                )
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: appThemeCtrl.mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          child: child ?? Container(),
        );
      },
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FluentLocalizations.delegate
      ],
      fallbackLocale: const Locale('pt', 'BR'),
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeService().theme,
      supportedLocales: Lang().locales,
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.baseRoute,
      getPages: Routers.pages,
    );


  }
}


Future<void> _initConfig() async {

  await flutter_acrylic.Window.initialize();
  await GetStorage.init();
  Get.put(AppPreferences());
  Get.put(AppTheme());
  var controller = Get.put(DirectoriesController());
  await controller.initDirectories();
  await IsarDB.init();
  await Lang().initializeLangSupported();

  doWhenWindowReady(() {
    const initialSize = Size(650, 670);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });

}