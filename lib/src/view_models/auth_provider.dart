import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
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
    try {
      if (await handleConnectionView(false)) {
        return;
      }
      setState(ViewState.LOADING);
      _repository.registerUser(request).then((response) {
        setState(ViewState.COMPLETE);
      }).onError((error, stackTrace) {
        final res = (error as DioError).response;
        errorCode = res!.statusCode.toString();
        errorMessage = res.data['message'].toString();
        setState(ViewState.ERROR);
      });
    } catch (_) {
      await handleConnectionView(false);
    }
  }
}
