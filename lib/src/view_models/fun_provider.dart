import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class FunProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  final List<CommentItem> _commentList = <CommentItem>[];
  final List<FunItem> _funList = <FunItem>[];

  List<FunItem>? get funList => _funList;

  List<CommentItem>? get commentList => _commentList;

  Future<void> getFunList({int? pagination = 1}) async {
    try {
      if (await handleConnectionView(_funList.isEmpty)) {
        return;
      }
      if (pagination == 1) {
        if (_funList.isEmpty) {
          setState(ViewState.LOADING);
        }
        _funList.clear();
      }

      _funList.addAll(
        await _repository.getFunList().then((value) => value.funList!),
      );
      setState(ViewState.COMPLETE);
    } catch (_) {
      await handleErrorView(_funList.isEmpty);
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
