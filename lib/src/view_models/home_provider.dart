import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/check_update_util.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class HomeProvider extends BaseViewModel {
  ForceUpdateDao? _forceUpdateDao;
  AppVersionVo? _appVersionVo;
  bool _isAlreadyUpdated = true;
  bool _isForceUpdate = false;
  var repository = locator<RepositoryImpl>();

  ForceUpdateDao? get forceUpdateDao => _forceUpdateDao;

  bool get isAlreadyUpdated => _isAlreadyUpdated;

  bool get isForceUpdate => _isForceUpdate;

  // // Local methods
  // void checkAppVersion() async {
  //   await repository.forceUpdate().then((value) => {
  //         _forceUpdateDao = value,
  //         _isForceUpdate = _forceUpdateDao!.forceUpdate!.isForceUpdate ?? false
  //       });
  //
  //   if (_forceUpdateDao != null) {
  //     await CheckUpdateUtil.getIsAlreadyUpdated(
  //             _forceUpdateDao!.forceUpdate!.versionName!)
  //         .then((value) => {_isAlreadyUpdated = value ?? true});
  //   }
  //   notifyListeners();
  // }

  // methods

  void checkAppVersion() async {
    await repository.checkAppVersion().then((value) => {
      _appVersionVo = value,
      _isForceUpdate = _appVersionVo!.forceUpdate ?? false
    });

    if (_appVersionVo != null) {
      await CheckUpdateUtil.getIsAlreadyUpdated(
          _appVersionVo!.version!)
          .then((value) => {_isAlreadyUpdated = value ?? true});
    }
    notifyListeners();
  }
}
