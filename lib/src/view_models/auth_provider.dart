import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/device_detail.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/request/request_login_vo.dart';
import 'package:wisdom/src/data_models/request/request_register_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class AuthProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  String errorCode = '';
  String errorMessage = '';

  AuthProvider() {
    setState(ViewState.NONE);
  }

  registerUser(RequestRegisterVO request) async {
    request.deviceId = await DeviceDetail.generateDeviceId();
    
    try {
      if (await handleConnectionView(false)) {
        return;
      }
      setState(ViewState.LOADING);
      _repository.registerUser(request).then((response) {
        setState(ViewState.COMPLETE);
        saveUser(response.token.toString(), response.user?.nickname ?? '');
      }).onError((error, stackTrace) {
        final res = (error as DioError).response;
        errorCode = res?.statusCode.toString() ?? '';
        errorMessage = res?.data['message'] ?? 'Unknown Error.\nPlease Try Later.';
        setState(ViewState.ERROR);
      });
    } catch (_) {
      await handleConnectionView(false);
    }
  }

  loginUser(RequestLoginVO request) async {
    try {
      if (await handleConnectionView(false)) {
        return;
      }
      setState(ViewState.LOADING);
      _repository.loginUser(request).then((response) {
        setState(ViewState.COMPLETE);
        saveUser(response.token.toString(), response.user?.nickname ?? '');
      }).onError((error, stackTrace) {
        final res = (error as DioError).response;
        errorCode = res?.statusCode.toString() ?? '';
        errorMessage = res?.data['message'] ?? 'Unknown Error.\nPlease Try Later.';
        setState(ViewState.ERROR);
      });
    } catch (_) {
      await handleConnectionView(false);
    }
  }

  void saveUser(String token, String nickName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('PREF_TOKEN', token);
    pref.setString('PREF_NAME', nickName);
  }
}
