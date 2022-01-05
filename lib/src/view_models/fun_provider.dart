import 'package:connectivity/connectivity.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/app_utils/response_view_state.dart';
import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class FunProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  final List<CommentItem> _commentList = <CommentItem>[];
   final List<FunItem> _funResponse = <FunItem>[];

  List<FunItem>? get funResponse => _funResponse;

  List<CommentItem>? get commentList => _commentList;

  Future<void> getFunList({int? pagination}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(ViewState.NO_INTERNET);
      return;
    }
    try {
      pagination ?? setState(ViewState.LOADING);
      _funResponse.addAll(await _repository.getFunList().then((value) =>  value.funList!));
      setState(ViewState.COMPLETE);

    } catch (_) {
      setState(ViewState.ERROR);
      rethrow;
    }
  }

  Future<void> getCommentList() async {
    try {
      await _repository.getCommentList().then(
            (value) => _commentList.addAll(
              value.commentList!.toList(),
            ),
          );
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
