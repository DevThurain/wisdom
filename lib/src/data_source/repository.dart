import 'package:wisdom/src/data_models/daos/force_update_dao.dart';

abstract class Repository {
  Future<ForceUpdateDao> forceUpdate();
}
