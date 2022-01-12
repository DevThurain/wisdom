import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;
  SharedPreferenceHelper(this._sharedPreference);

  Future<bool?> getBool(String key) async {
    return _sharedPreference.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return _sharedPreference.setBool(key, value);
  }

  Future<String> getString(String key) async {
    return _sharedPreference.getString(key) ?? '';
  }

  Future<void> clear() async {
    _sharedPreference.clear();
  }

  // Future<bool> removeAuthToken() async {
  //   return _sharedPreference.remove(Preferences.auth_token);
  // }

}
