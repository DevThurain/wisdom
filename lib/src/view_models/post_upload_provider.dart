import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/app_utils/user_profile_generator.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_upload_response.dart';
import 'package:wisdom/src/data_models/vos/knowledge_list_vo.dart';
import 'package:wisdom/src/data_models/vos/knowledge_upload_response.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class PostUploadProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();

  String _userProfile = "";
  String _userName = "";

  String get userProfile => _userProfile;

  String get userName => _userName;


  Future<void> getUserProfile() async {
    await SharedPreferences.getInstance().then((_pref) {
      _userProfile =
          TempProfileGenerator.getTempProfileUrl(_pref.getInt('PREF_USER_ID'));
      _userName = _pref.getString('PREF_NAME') ?? "";
    });
    notifyListeners();
  }

  Future<void> uploadFunPost(String content, BuildContext context) async {
    if (await handleConnectionView(isReplaceView: false)) {
      return;
    }
    if (content.isEmpty) {
      setNotifyMessage("Type something to post");
      return;
    }

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.dark_purple,
        content: const Text('Uploading..'),
      ),
    );

    await _repository.funPostUpload(content).then((value) {
      FunUploadResponse funUploadResponse = value;

      FunItem uploadedFunItem = FunItem(
          id: funUploadResponse.data!.id,
          post: funUploadResponse.data!.post,
          date: funUploadResponse.data!.date,
          commentCount: funUploadResponse.data!.commentCount,
          createdAt: funUploadResponse.data!.createdAt,
          creator: FunCommentCreator(
            id: funUploadResponse.data!.creator!.id,
            nickname: funUploadResponse.data!.creator!.nickname,
          ));
      scaffold.hideCurrentSnackBar();
      Navigator.pop(context, uploadedFunItem);

    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      Fluttertoast.showToast(
          msg: res?.data['message'] ?? 'Unknown Error. Please Try Later.');
    });
    notifyListeners();
  }

  Future<void> uploadKnowledgePost(String content, BuildContext context) async {
    if (await handleConnectionView(isReplaceView: false)) {
      return;
    }
    if (content.isEmpty) {
      setNotifyMessage("Type something to post");
      return;
    }

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.dark_purple,
        content: const Text('Uploading..'),
      ),
    );

    await _repository.knowledgePostUpload(content).then((value) {
      KnowledgeUploadResponse knowledgeUploadResponse = value;

      KnowledgeItem uploadedFunItem = KnowledgeItem(
          id: knowledgeUploadResponse.data!.id,
          note: knowledgeUploadResponse.data!.note,
          date: knowledgeUploadResponse.data!.date,
          createdAt: knowledgeUploadResponse.data!.createdAt,
          creator: KnowledgeCommentCreator(
            id: knowledgeUploadResponse.data!.creator!.id,
            nickname: knowledgeUploadResponse.data!.creator!.nickname,
          ));
      scaffold.hideCurrentSnackBar();
      Navigator.pop(context, uploadedFunItem);

    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      Fluttertoast.showToast(
          msg: res?.data['message'] ?? 'Unknown Error. Please Try Later.');
    });
    notifyListeners();
  }


}
