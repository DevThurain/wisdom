import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/vos/knowledge_list_vo.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class KnowledgeProvider extends BaseViewModel {
  final _repository = locator<RepositoryImpl>();
  final List<KnowledgeItem> _knowledgeList = <KnowledgeItem>[];

  List<KnowledgeItem>? get knowledgeList => _knowledgeList;

  Future<void> getKnowledgeList({int? currentPage = 1}) async {
    try {
      if (await handleConnectionView(isReplaceView: _knowledgeList.isEmpty)) {
        return;
      }
      if (currentPage == 1) {
        if (_knowledgeList.isEmpty) {
          setState(ViewState.LOADING);
        }
        _knowledgeList.clear();
      }

      _knowledgeList.addAll(
        await _repository.getKnowledgeList().then((value) => value.knowledgeList!),
      );
      setState(ViewState.COMPLETE);
    } catch (_) {
      await handleErrorView(_knowledgeList.isEmpty);
      rethrow;
    }
  }

  void updateKnowledgeList(KnowledgeItem knowledgeItem) {
    _knowledgeList.insert(0, knowledgeItem);
    setState(ViewState.COMPLETE);
  }




}
