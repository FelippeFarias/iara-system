import 'package:logger/logger.dart';
import 'package:windows_foundation/windows_foundation.dart';
import 'package:windows_ui/windows_ui.dart';

abstract class UiUtils{
 static Future<void> showDialog() async {
    const title = 'Updates available';
    const content = 'New updates have been found for this program. Would you '
        'like to install the new updates?';
    // Create a message dialog
    final messageDialog = MessageDialog.createWithTitle(content, title);

    // Initialize the MessageDialog
    InitializeWithWindow.initialize(messageDialog);

    // Add commands
    messageDialog.commands
      ?..append(UICommand.create('Install updates'))
      ..append(UICommand.create("Don't install"));

    messageDialog
    // Set the command that will be invoked by default
      ..defaultCommandIndex = 0
    // Set the command to be invoked when escape is pressed
      ..cancelCommandIndex = 1;

    // Show the message dialog
    final selectedCommand = await messageDialog.showAsync();

    switch (selectedCommand?.label) {
      case 'Install updates':
        print('"Install updates" button is selected.');
      case "Don't install":
        print('"Don\'t install" button is selected.');
    }
  }
 static Future<void> uiSettings() async {
   final uiSettings = UISettings();
   Logger().d(uiSettings.toString());
 }
}