import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';

abstract class Repository {

  //Sample Local
  Future<ForceUpdateDao> forceUpdate();
  Future<FactListDao> fetchListPaginated(int limit,int page);
  Future<FunListDao> getFunList();
  Future<CommentListDao> getCommentList();


  //Server Request
  Future<AppVersionVo> checkAppVersion();

}
