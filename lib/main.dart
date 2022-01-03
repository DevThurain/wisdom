import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisdom/src/app_utils/locator.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  await setupLocator();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // transparent status bar
      statusBarIconBrightness: Brightness.dark // dark text for status bar
  ));
  runApp(MyApp(settingsController: settingsController));
}
