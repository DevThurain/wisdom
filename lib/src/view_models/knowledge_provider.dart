import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_source/repository_impl.dart';

class KnowlegeProvider extends ChangeNotifier {
  int page = 1;
  List<Datum> facts = [];
  bool paginateLock = false;

  var repository = locator<RepositoryImpl>();

  KnowlegeProvider() {
    fetchPaginatedList();
  }

  fetchPaginatedList() {
    repository.fetchListPaginated(5, page).then((value) {
      facts += value.data!;

      if (page < value.lastPage!.toInt()) page++;
      paginateLock = false;
      notifyListeners();
    });
  }
}
