import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wisdom/src/app_utils/device_detail.dart';
import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';
import 'package:wisdom/src/data_models/vos/post_list_vo.dart';
import 'package:wisdom/src/data_source/network/wisdom_api.dart';
import 'package:wisdom/src/data_source/repository.dart';

class RepositoryImpl implements Repository {
  late WisdomAPI mApi;

  static final RepositoryImpl _singleton = RepositoryImpl.internal();

  factory RepositoryImpl() {
    return _singleton;
  }

  RepositoryImpl.internal() {
    //TODO:User Token => Get From Share Preferences or Some Storage
    const String userToken = "159|hQQA49IHNxx5c80NVrmB6vTVLq2PVI3rsWl1ABVx";
    final dio = Dio();
    dio.options.connectTimeout = 10000;

    if(userToken == null){
      dio.options.headers = {
        "Content-Type": Headers.jsonContentType,
        "Accept": Headers.jsonContentType,
        "X-API-TOKEN": "ZBJ3MafcVGQvEdCYPfGT",
      };
    }else {
      dio.options.headers = {
        "Content-Type": Headers.jsonContentType,
        "Accept": Headers.jsonContentType,
        "X-API-TOKEN": "ZBJ3MafcVGQvEdCYPfGT",
        "Authorization": "Bearer " + userToken
      };
    }

// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    mApi = WisdomAPI(dio);
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
    final String response =
    await rootBundle.loadString('assets/jsons/fun_list.json');
    var data = json.decode(response);
    return FunListDao.fromJson(data);
  }

  @override
  Future<CommentListDao> getCommentList() async {
    final String response =
    await rootBundle.loadString('assets/jsons/comment_list.json');
    var data = json.decode(response);
    return CommentListDao.fromJson(data);
  }

  @override
  Future<AppVersionVo> checkAppVersion() {
    return mApi.checkAppVersion();
  }

  @override
  Future<PostListVo> getFunList() {
    return mApi.getFunList();
  }
}
