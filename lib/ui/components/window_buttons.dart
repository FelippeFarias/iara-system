 import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/theme.dart';

class WindowButtons extends StatelessWidget {
    WindowButtons({Key? key, this.showCloseButton = true, this.showMaximizeButton = true, this.showMinimizeButton = true}) : super(key: key);
  final appTheme = Get.find<AppTheme>();
  final bool showCloseButton;
  final bool showMaximizeButton;
  final bool showMinimizeButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: WindowButtonColors(iconNormal: appTheme.hintColor),).hide(isVisible: showMinimizeButton),
        MaximizeWindowButton(colors: WindowButtonColors(iconNormal: appTheme.hintColor),).hide(isVisible: showMaximizeButton),
        CloseWindowButton(colors: WindowButtonColors(iconNormal: appTheme.hintColor),).hide(isVisible: showCloseButton),
      ],
    );
  }
}
