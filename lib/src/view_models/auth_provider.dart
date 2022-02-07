import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/device_detail.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/request/request_login_vo.dart';
import 'package:wisdom/src/data_models/request/request_register_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';

class AuthProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  String errorCode = '';
  String errorMessage = '';

  AuthProvider() {
    setState(ViewState.NONE);
  }

  registerUser(RequestRegisterVO request) async {
    //request.deviceId = DateTime.now().millisecondsSinceEpoch.toString();
    request.deviceId = await DeviceDetail.generateDeviceId();

    try {
      if (await handleConnectionView()) {
        return;
      }
      if (request.code.isEmpty) {
        setNotifyMessage('refer code required.');
        return;
      }
      if (request.nickname.isEmpty || request.password.isEmpty) {
        setNotifyMessage('nickname & password required.');
        return;
      }
      setState(ViewState.LOADING);
      _repository.registerUser(request).then((response) {
        setState(ViewState.COMPLETE);
        saveUser(
            response.user!.id!, response.token.toString(), response.user?.nickname ?? '');
      }).onError((error, stackTrace) {
        print(error.toString());
        switch (error.runtimeType) {
          case DioError:
            final res = (error as DioError).response;
            errorCode = res?.statusCode.toString() ?? '';
            errorMessage = res?.data['message'] ?? 'Unknown Error.\nPlease Try Later.';
            break;

          case TypeError:
            errorCode = "Type Error";
            errorMessage = 'Invalid Json Format';
            break;

          default:
            errorCode = "Non";
            errorMessage = 'Unknown Error';
            break;
        }
        setState(ViewState.ERROR);
      });
    } catch (_) {
      await handleConnectionView(isReplaceView: false);
    }
  }

  loginUser(RequestLoginVO request) async {
    try {
      if (await handleConnectionView()) {
        return;
      }
      if (request.nickname.isEmpty || request.password.isEmpty) {
        setNotifyMessage('nickname & password required.');
        return;
      }
      setState(ViewState.LOADING);
      _repository.loginUser(request).then((response) {
        setState(ViewState.COMPLETE);
        saveUser(
            response.user!.id!, response.token.toString(), response.user?.nickname ?? '');
      }).onError((error, stackTrace) {
        print(error.runtimeType.toString());
        switch (error.runtimeType) {
          case DioError:
            final res = (error as DioError).response;
            errorCode = res?.statusCode.toString() ?? '';
            errorMessage = res?.data['message'] ?? 'Unknown Error.\nPlease Try Later.';
            break;

          case TypeError:
            errorCode = "Type Error";
            errorMessage = 'Invalid Json Format';
            break;

          case NoSuchMethodError:
            errorCode = "Type Error";
            errorMessage = 'Invalid Json Format';
            break;

          case JsonUnsupportedObjectError:
            errorCode = "Type Error";
            errorMessage = 'Invalid Json Format';
            break;

          // default:
          //   errorCode = "Non";
          //   errorMessage = 'Unknown Error';
          //   break;
        }
        setState(ViewState.ERROR);
      });
    } catch (_) {
      await handleConnectionView();
    }
  }

  void saveUser(int userId, String token, String nickName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(PREF_USER_ID, userId);
    pref.setString(PREF_AUTH_TOKEN, token);
    pref.setString(PREF_USER_NAME, nickName);
  }
}
