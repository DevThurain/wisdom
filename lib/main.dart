import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/view_models/ad_state.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init ads
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
  });



  await setupLocator();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(settingsController: settingsController),
  ));
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}