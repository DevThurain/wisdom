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
  runApp(MyApp(settingsController: settingsController));
}
