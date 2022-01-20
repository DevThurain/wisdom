import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wisdom/src/app_utils/device_detail.dart';
import 'package:wisdom/src/app_utils/locator.dart';
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
import 'package:wisdom/src/data_source/repository.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';
import 'package:wisdom/src/data_source/source/api_source.dart';

class RepositoryImpl implements Repository {
  late ApiSource _mSource;
  late final SharedPreferenceHelper _pref = locator<SharedPreferenceHelper>();

  static final RepositoryImpl _singleton = RepositoryImpl.internal();

  factory RepositoryImpl() {
    return _singleton;
  }

  RepositoryImpl.internal() {
    _mSource = ApiSource();
  }

  //force update
  @override
  Future<ForceUpdateDao> forceUpdate() async {
    int osType = DeviceDetail.getOSType();
    print("Os Type $osType");
    final String response =
        await rootBundle.loadString('assets/jsons/force_update_api.json');
    var data = json.decode(response);
    return ForceUpdateDao.fromJson(data);
  }

  @override
  Future<FactListDao> fetchListPaginated(int limit, int page) async {
    var url = Uri.parse('https://catfact.ninja/facts?limit=$limit&page=$page');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    return FactListDao.fromJson(data);
  }

  @override
  Future<FunListDao> getLocalFunList() async {
    await Future.delayed(Duration(seconds: 3));
    final String response = await rootBundle.loadString('assets/jsons/fun_list.json');
    var data = json.decode(response);
    return FunListDao.fromJson(data);
  }

  @override
  Future<CommentListDao> getCommentList() async {
    final String response = await rootBundle.loadString('assets/jsons/comment_list.json');
    var data = json.decode(response);
    return CommentListDao.fromJson(data);
  }

  @override
  Future<AppVersionVo> checkAppVersion() {
    return _mSource.publicApi().checkAppVersion();
  }

  @override
  Future<ResponseRegisterVO> registerUser(RequestRegisterVO request) {
    return _mSource
        .publicApi()
        .registerUser(request.nickname, request.code, request.deviceId, request.password);
  }

  @override
  Future<ResponseLoginVO> loginUser(RequestLoginVO request) {
    return _mSource.publicApi().loginUser(request.nickname, request.password);
  }

  @override
  Future<FunListVo> getFunList(int page) {
    return _mSource.privateApi().getFunList(page);
  }

  @override
  Future<FunDetailVo> getCommentListById(int postId) {
    return _mSource.privateApi().getFunDetail(postId, true);
  }

  @override
  Future<ResponseSuccessVO> logoutUser() {
    return _mSource.privateApi().logoutUser();
  }

  @override
  Future<CommentResponseVo> sendComment(int postId, String commentData) {
    return _mSource.privateApi().commentFunDetail(postId, commentData);
  }

  @override
  Future<KnowledgeListVo> getKnowledgeList(int page) {
    return _mSource.privateApi().getKnowledgeList(page);
  }

  @override
  Future<FunUploadResponse> funPostUpload(String content) {
    return _mSource.privateApi().createFunPost(content);
  }

  @override
  Future<KnowledgeUploadResponse> knowledgePostUpload(String content,
      {String link = ""}) {
    return _mSource.privateApi().createKnowledgePost(content, link);
  }

  @override
  Future<ResponseUserProfileVO> getUserProfile() {
    return _mSource.privateApi().getUserProfile();
  }

  @override
  Future<EditProfileResponse> updateNickName(String nickName) {
    return _mSource.privateApi().updateUserProfile(nickName);
  }

  @override
  Future<FunListVo> getMyFunList(int page) {
    return _mSource.privateApi().getMyFunList(page);
  }

  @override
  Future<ResponseSuccessVO> deletePostById(int postId) {
    return _mSource.privateApi().deletePostById(postId);
  }
}


// Future<bool> checkTokenStored() async {
//   var _pref = await SharedPreferences.getInstance();
//   String token = _pref.getString(PREF_AUTH_TOKEN) ?? '';
//   return token.isNotEmpty;
// }