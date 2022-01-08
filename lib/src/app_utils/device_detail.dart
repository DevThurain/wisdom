import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DeviceDetail {
  static Future<String> generateDeviceId() async {
    String identifier = "";
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    return identifier;
  }

  static int getOSType() {
    return Platform.isAndroid ? 1 : 2;
  }
}
