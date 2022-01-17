import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/view_models/ad_state.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';
import 'package:wisdom/src/view_models/home_provider.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init ads
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  

  await setupLocator();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(settingsController: settingsController),
  ));
}
