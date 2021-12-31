import 'package:flutter/services.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_source/repository.dart';
import 'dart:convert';

class RepositoryImpl implements Repository {

  //force update
  @override
  Future<ForceUpdateDao> forceUpdate() async {
    final String response =
        await rootBundle.loadString('assets/jsons/force_update_api.json');
    var data = json.decode(response);
    return ForceUpdateDao.fromJson(data);
  }
}
