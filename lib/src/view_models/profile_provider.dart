import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/response/response_user_profile_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';

class ProfileProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  final _pref = locator<SharedPreferenceHelper>();

  ResponseUserProfileVO? _responseUserProfileVO;
  final List<FunItem> _funList = <FunItem>[];
  int? _currentSelectedFanId;
  int currentPage = 1;

  ResponseUserProfileVO? get responseUserProfileVO => _responseUserProfileVO;

  List<FunItem>? get funList => _funList;

  set currentSelectedFanId(int value) {
    _currentSelectedFanId = value;
  }

  Future<void> getUserProfile() async {
    await _repository.getUserProfile().then((value) {
      _responseUserProfileVO = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      Fluttertoast.showToast(
          msg: res?.data['message'] ?? 'Unknown Error. Please Try Later.');
    });
  }

  Future<void> getMyFunList() async {
    try {
      if (await handleConnectionView(isReplaceView: _funList.isEmpty)) {
        return;
      }
      if (currentPage == 1) {
        if (_funList.isEmpty) {
          setState(ViewState.LOADING);
        }
        _funList.clear();
      }

      _funList.addAll(
        await _repository.getMyFunList(currentPage).then((value) {
          currentPage += 1;
          return value.funList!;
        }),
      );
      setState(ViewState.COMPLETE);
    } catch (_) {
      await handleErrorView(_funList.isEmpty);
      rethrow;
    }
  }

  void updateCommentCount(int updatedCommentCount) {
    _funList[_currentSelectedFanId!].setCommentCount = updatedCommentCount;
    setState(ViewState.COMPLETE);
  }

  Future<void> saveNickName(String nickName) async {
    if (nickName.isEmpty) {
      setNotifyMessage("Your nick name is empty.");
      return;
    }
    await _repository.updateNickName(nickName).then((value) {
      _responseUserProfileVO!.data!.setNickname = value.data!.nickname ?? "";
      _pref.setString(PREF_USER_NAME, value.data!.nickname ?? "");
      setNotifyMessage("Nick name successfully changed");
    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      setNotifyMessage(res?.data['message']);
    });
  }

  void refreshList() {
    currentPage = 1;
    getMyFunList();
  }

  Future<void> deletePost(
      {required int postId, required int position, required BuildContext context}) async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.dark_purple,
        content: const Text('Removing..'),
      ),
    );
    await _repository.deletePostById(postId).then((value) {
      
      _funList.removeWhere((element) => element.id == postId);
      scaffold.hideCurrentSnackBar();
      notifyListeners();

    }).onError((error, stackTrace) {
      scaffold.hideCurrentSnackBar();

      final res = (error as DioError).response;
      setNotifyMessage(res?.data['message']);
    });
  }
}
