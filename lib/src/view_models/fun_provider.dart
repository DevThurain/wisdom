import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/vos/comment_response_vo.dart';
import 'package:wisdom/src/data_models/vos/fun_detail_vo.dart';
import 'package:wisdom/src/data_models/vos/post_list_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class FunProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  final List<FunItem> _funList = <FunItem>[];
  final List<Comments> _commentList = <Comments>[];
   int? _currentSelectedFanId;

  List<FunItem>? get funList => _funList;

  List<Comments>? get commentList => _commentList;


  set currentSelectedFanId(int value) {
    _currentSelectedFanId = value;
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
        await _repository.getFunList().then((value) => value.funList!),
      );
      setState(ViewState.COMPLETE);
    } catch (_) {
      await handleErrorView(_funList.isEmpty);
      rethrow;
    }
  }

  Future<void> getFunCommentListByPostId({int? postId = 0}) async {
    try {
      if (await handleConnectionView()) {
        return;
      }
      FunDetailVo funDetailVo = FunDetailVo();
      await _repository
          .getCommentListById(postId!)
          .then((value) => funDetailVo = value);

      _commentList.addAll(funDetailVo.data!.comments ?? []);
      setState(ViewState.COMPLETE);
    } catch (_) {
      await handleErrorView(_commentList.isEmpty);
      rethrow;
    }
  }

  Future<void> addComment(int postId, String commentData) async {
    CommentResponseVo _postCommentResponse = CommentResponseVo();

    await _repository.sendComment(postId, commentData).then((value) {
      _postCommentResponse = value;
    }).onError((error, stackTrace) {
      final res = (error as DioError).response;
      Fluttertoast.showToast(
          msg: res?.data['message'] ?? 'Unknown Error. Please Try Later.');
    });


    if (_postCommentResponse.data != null) {
      Comment _postedSuccessComment = _postCommentResponse.data!;

      _commentList.add(Comments(
        id: _postedSuccessComment.id,
        postId: _postedSuccessComment.postId,
        date: _postedSuccessComment.date,
        createdAt: _postedSuccessComment.createdAt,
        comment: _postedSuccessComment.comment,
        creator: CommentCreator(
            id: _postedSuccessComment.creator!.id,
            nickname: _postedSuccessComment.creator!.nickname),
      ));

    }
    setState(ViewState.NONE);
  }

  updateCommentCount(int updatedCommentCount){
    _funList[_currentSelectedFanId!].setCommentCount = updatedCommentCount;
    setState(ViewState.COMPLETE);
  }

}
