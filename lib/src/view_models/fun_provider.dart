import 'package:flutter/cupertino.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class FunProvider with ChangeNotifier{
  final _repository = locator<RepositoryImpl>();
  FunListDao? _funListDao;
  CommentListDao? _commentListDao;

  FunListDao? get funListDao => _funListDao;
  CommentListDao? get commentListDao => _commentListDao;


  Future<void> getFunList() async {
    try {
      _funListDao = await _repository.getFunList();
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getCommentList() async {
    try {
      _commentListDao = await _repository.getCommentList();
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }


}