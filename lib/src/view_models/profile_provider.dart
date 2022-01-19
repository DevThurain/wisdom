import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/response/response_user_profile_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class ProfileProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  ResponseUserProfileVO? _responseUserProfileVO;
  final List<FunItem> _funList = <FunItem>[];

  ResponseUserProfileVO? get responseUserProfileVO => _responseUserProfileVO;
  List<FunItem>? get funList => _funList;

  Future<void> getUserProfile() async {
    await _repository.getUserProfile().then((value) {
      _responseUserProfileVO = value;

    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      Fluttertoast.showToast(
          msg: res?.data['message'] ?? 'Unknown Error. Please Try Later.');
    });
  }

  Future<void> getFunList({int? currentPage = 1}) async {
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
        await _repository.getFunList(currentPage!).then((value) => value.funList!),
      );
      setState(ViewState.COMPLETE);
    } catch (_) {
      await handleErrorView(_funList.isEmpty);
      rethrow;
    }
  }


  Future<void> saveNickName(String nickName) async{
    if (nickName.isEmpty) {
      setNotifyMessage("Your nick name is empty.");
      return;
    }
    await _repository.updateNickName(nickName).then((value)  {
    setNotifyMessage("success");
    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      setNotifyMessage(res?.data['message']);
    });
  }

}
