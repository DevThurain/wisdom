import 'package:flutter/cupertino.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class FunProvider with ChangeNotifier{
  final _repository = locator<RepositoryImpl>();
  final List<CommentItem>  _commentList = <CommentItem>[];
  final List<FunItem>  _funList = <FunItem>[];

  List<FunItem>? get funList => _funList;
  List<CommentItem>? get commentList => _commentList;


  Future<void> getFunList() async {
    try {
       await _repository.getFunList().then((value) =>
          _funList.addAll(value.funList!.toList())
      );
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getCommentList() async {
    try {
      await _repository.getCommentList().then((value) =>
          _commentList.addAll(value.commentList!.toList())
      );
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }


}