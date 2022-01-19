import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_models/request/request_login_vo.dart';
import 'package:wisdom/src/data_models/request/request_register_vo.dart';
import 'package:wisdom/src/data_models/response/response_login_vo.dart';
import 'package:wisdom/src/data_models/response/response_profile_edit.dart';
import 'package:wisdom/src/data_models/response/response_register_vo.dart';
import 'package:wisdom/src/data_models/response/response_success_vo.dart';
import 'package:wisdom/src/data_models/response/response_user_profile_vo.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
import 'package:wisdom/src/data_models/vos/comment_response_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_detail_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_upload_response.dart';
import 'package:wisdom/src/data_models/vos/knowledge_list_vo.dart';
import 'package:wisdom/src/data_models/vos/knowledge_upload_response.dart';

abstract class Repository {
  //Sample Local
  Future<ForceUpdateDao> forceUpdate();
  Future<FactListDao> fetchListPaginated(int limit, int page);
  Future<FunListDao> getLocalFunList();
  Future<CommentListDao> getCommentList();

  //Server Request
  Future<AppVersionVo> checkAppVersion();
  Future<ResponseRegisterVO> registerUser(RequestRegisterVO request);
  Future<ResponseLoginVO> loginUser(RequestLoginVO request);
  Future<ResponseSuccessVO> logoutUser();
  Future<FunListVo> getFunList(int page);
  Future<FunDetailVo> getCommentListById(int postId);
  Future<CommentResponseVo> sendComment(int postId, String commentData);
  Future<KnowledgeListVo> getKnowledgeList(int page);
  Future<FunUploadResponse> funPostUpload(String content);
  Future<KnowledgeUploadResponse> knowledgePostUpload(String content, {String link = ""});
  Future<ResponseUserProfileVO> getUserProfile();
  Future<EditProfileResponse> updateNickName(String nickName);
}
