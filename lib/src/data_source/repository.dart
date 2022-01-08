import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';

abstract class Repository {
  Future<ForceUpdateDao> forceUpdate();
  Future<FactListDao> fetchListPaginated(int limit,int page);
  Future<FunListDao> getFunList();
  Future<CommentListDao> getCommentList();
}
