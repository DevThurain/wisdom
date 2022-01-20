import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/check_update_util.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/app_utils/user_profile_generator.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';

class HomeProvider extends BaseViewModel {
  ForceUpdateDao? _forceUpdateDao;
  AppVersionVo? _appVersionVo;
  bool _isAlreadyUpdated = true;
  bool _isForceUpdate = false;
  bool show = true;
  bool logout = false;
  String errorCode = '';
  String errorMessage = '';
  String? _userProfile;
  var repository = locator<RepositoryImpl>();

  ForceUpdateDao? get forceUpdateDao => _forceUpdateDao;

  bool get isAlreadyUpdated => _isAlreadyUpdated;

  AppVersionVo? get appVersionVo => _appVersionVo;

  bool get isForceUpdate => _isForceUpdate;

  String? get userProfile => _userProfile;

  // methods

  Future<void> checkAppVersion() async {
    await repository.checkAppVersion().then((value) =>
        {_appVersionVo = value, _isForceUpdate = _appVersionVo!.forceUpdate ?? false});

    if (_appVersionVo != null) {
      await CheckUpdateUtil.getIsAlreadyUpdated(_appVersionVo!.version!)
          .then((value) => {_isAlreadyUpdated = value ?? true});
    }
  }

  Future<void> getUserProfile() async {
    await SharedPreferences.getInstance().then((_pref) => _userProfile =
        TempProfileGenerator.getTempProfileUrl(_pref.getInt(PREF_USER_ID)));
    notifyListeners();
  }
}
