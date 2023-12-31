
 import 'package:iara/ui/screens/base/base_screen.dart';
import 'package:iara/ui/screens/connection/controllers/connection_binding.dart';
import 'package:iara/ui/screens/serial/controllers/serial_binding.dart';
import 'package:iara/ui/screens/settings/controllers/settings_binding.dart';
import 'package:iara/ui/screens/settings/settings_screen.dart';
import 'package:iara/ui/screens/status/controllers/meet_connection_binding.dart';
import 'package:iara/ui/screens/status/meet_connection_screen.dart';
import 'package:get/get.dart';

import '../ui/screens/base/controllers/base_binding.dart';
import '../ui/screens/home/controllers/home_binding.dart';
import '../ui/screens/socket/controllers/socket_binding.dart';

abstract class Routers {
  static const transaction  =   Transition.downToUp;
  static final pages = <GetPage> [
    GetPage(
      page: () => BaseScreen(),
      name: PagesRoutes.baseRoute,
      transition: transaction,
      bindings: [
        BaseBinding(),
        ConnectionBinding(),
        HomeBinding(),

      ],
    ),
    GetPage(
      page: () => SettingsScreen(),
      name: PagesRoutes.settingsRoute,
      transition: transaction,
      bindings: [
        SettingsBinding(),
      ],
    ),
    GetPage(
      page: () => MeetConnectionPage(),
      name: PagesRoutes.meetConnectionRoute,
      transition: transaction,
      bindings: [
        MeetConnectionBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String baseRoute = '/base';
  static const String homeRoute = '/home';
  static const String settingsRoute = '/settings';
  static const String meetConnectionRoute = '/meetConnection';

}
