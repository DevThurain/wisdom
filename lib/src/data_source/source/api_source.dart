import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wisdom/src/data_source/network/wisdom_api.dart';

class ApiSource {
  late Dio dio;
  late WisdomAPI mApi;

  static final ApiSource _singleton = ApiSource.internal();

  factory ApiSource() {
    return _singleton;
  }

  ApiSource.internal() {
    dio = Dio();
    dio.options.connectTimeout = 10000;
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  DioSource() {}

  WisdomAPI publicApi() {
    dio.options.headers = {
      "Content-Type": Headers.jsonContentType,
      "Accept": Headers.jsonContentType,
      "X-API-TOKEN": "ZBJ3MafcVGQvEdCYPfGT",
    };

    mApi = WisdomAPI(dio);

    return mApi;
  }

  WisdomAPI privateApi(String token) {
    dio.options.headers = {
      "Content-Type": Headers.jsonContentType,
      "Accept": Headers.jsonContentType,
      "X-API-TOKEN": "ZBJ3MafcVGQvEdCYPfGT",
      "Authorization": "Bearer " + token
    };

    mApi = WisdomAPI(dio);
    return mApi;
  }
}
