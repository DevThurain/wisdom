import 'package:package_info_plus/package_info_plus.dart';

class CheckUpdateUtil{
 static Future<bool?> getIsAlreadyUpdated(String newVersionName) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      if (int.parse(newVersionName.replaceAll(".", "")) <=
          (int.parse(packageInfo.version.replaceAll(".", "")))) {
        return true;
      }else {
        return false;
      }
    }catch(_){
      return false;
    }
  }
}