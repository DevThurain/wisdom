import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';
import 'package:wisdom/src/view_models/home_provider.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  await setupLocator();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  var knowledgeProvider = locator<KnowlegeProvider>();
  var homeProvider = locator<HomeProvider>();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => knowledgeProvider),
    ],
    child: MyApp(settingsController: settingsController)));
}
