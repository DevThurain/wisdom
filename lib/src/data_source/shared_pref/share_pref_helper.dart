import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const String PREF_USER_NAME = "PREF_USER_NAME";
const String PREF_USER_ID = "PREF_USER_ID";
const String PREF_AUTH_TOKEN = "PREF_AUTH_TOKEN";

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);


  void setBool(String key, bool value) => _sharedPreference.setBool(key, value);

  void setString(String key, String value) async => _sharedPreference.setString(key, value);

  void setInt(String key, int value) async => _sharedPreference.setInt(key, value);

  bool? getBool(String key)  {
    return _sharedPreference.getBool(key);
  }

  String getString(String key)  {
    return _sharedPreference.getString(key) ?? '';
  }

  int? getInt(String key)  {
    return _sharedPreference.getInt(key);
  }

  Future<void> clear() async {
    _sharedPreference.clear();
  }


// Future<bool> removeAuthToken() async {
//   return _sharedPreference.remove(Preferences.auth_token);
// }

}
