
import 'package:iara/ui/screens/serial/serial_page.dart';
import 'package:iara/ui/screens/socket/socket_page.dart';
import 'package:iara/utils/asset_paths.dart';
import 'package:iara/utils/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {

  final _appTheme = Get.find<AppTheme>();
  int currentIndex = 0;
  List<Tab> tabs = [];

  @override
  Widget build(BuildContext context) {
    return TabView(

      tabs: [
        Tab(

        text: const Text('Socket'),
        semanticLabel: 'Socket',
        icon: const Icon( FluentIcons.wifi),
        body: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:  _appTheme.cardColor,
            ),
          padding: const EdgeInsets.all(20.0),
          child:   SocketPage()),
      ),
        Tab(
          text: const Text('Serial'),
          semanticLabel: 'Serial Connection',
          icon: SvgPicture.asset(AssetPaths.ic_serial, width: 20, height: 20,
              colorFilter:  ColorFilter.mode( _appTheme.textColor,  BlendMode.srcIn,)),
          body: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:  _appTheme.cardColor,
            ),
              padding: const EdgeInsets.all(20.0),

              child:   SerialPage()),
        ),
      ],
      currentIndex: currentIndex,
      onChanged: (index) => setState(() => currentIndex = index),
      tabWidthBehavior: TabWidthBehavior.equal,
      closeButtonVisibility: CloseButtonVisibilityMode.never,
      showScrollButtons: true,
      onNewPressed: null,

      /*onNewPressed: () {
          setState(() {
            final index = tabs!.length + 1;
            final tab = generateTab(index);
            tabs!.add(tab);
          });
        },*/
    );
  }

}
