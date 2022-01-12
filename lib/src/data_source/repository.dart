import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_models/request/request_login_vo.dart';
import 'package:wisdom/src/data_models/request/request_register_vo.dart';
import 'package:wisdom/src/data_models/response/response_login_vo.dart';
import 'package:wisdom/src/data_models/response/response_register_vo.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
import 'package:wisdom/src/data_models/vos/post_list_vo.dart';

abstract class Repository {
  //Sample Local
  Future<ForceUpdateDao> forceUpdate();
  Future<FactListDao> fetchListPaginated(int limit,int page);
  Future<FunListDao> getLocalFunList();
  Future<CommentListDao> getCommentList();

  //Server Request
  Future<AppVersionVo> checkAppVersion();
  Future<ResponseRegisterVO> registerUser(RequestRegisterVO request);
  Future<ResponseLoginVO> loginUser(RequestLoginVO request);
  Future<PostListVo> getFunList();

}
