import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class HomeProvider extends ChangeNotifier {
  ForceUpdateDao? _forceUpdateDao;
  String _versionStatus = '';

  var repository = locator<RepositoryImpl>();

  String get versionStatus => _versionStatus;

  HomeProvider() {
    checkVersion();
  }

  // methods
  void checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVer = packageInfo.version;
    
    _forceUpdateDao = await repository.forceUpdate();

    _versionStatus =
        'current version is $currentVer \n latest version is ${_forceUpdateDao!.update!.last.version}';

    print(_versionStatus);
    notifyListeners();
  }
}
