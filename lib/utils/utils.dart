import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'constants.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}
Future<void> playAlertSound(String soundPath) async {
  final player = AudioPlayer();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await player.play(AssetSource(soundPath));
  });

}


void showSnack({String? title, required String message,Color? color}) {
  Get.snackbar(
    title ??'',
    message,
    backgroundColor: color ??Constants.kPrimaryColor,
    colorText: Colors.white,
    duration: 3.seconds,

    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(16),
  );
}