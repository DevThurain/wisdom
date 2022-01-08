import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/check_update_util.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class HomeProvider extends BaseViewModel {
  ForceUpdateDao? _forceUpdateDao;
  bool _isAlreadyUpdated = true;
  bool _isForceUpdate = false;
  var repository = locator<RepositoryImpl>();

  ForceUpdateDao? get forceUpdateDao => _forceUpdateDao;

  bool get isAlreadyUpdated => _isAlreadyUpdated;

  bool get isForceUpdate => _isForceUpdate;

  // methods
  void checkVersion() async {
    await repository.forceUpdate().then((value) => {
          _forceUpdateDao = value,
          _isForceUpdate = _forceUpdateDao!.forceUpdate!.isForceUpdate ?? false
        });

    if (_forceUpdateDao != null) {
      await CheckUpdateUtil.getIsAlreadyUpdated(
              _forceUpdateDao!.forceUpdate!.versionName!)
          .then((value) => {_isAlreadyUpdated = value ?? true});
    }
    notifyListeners();
  }
}
