import 'package:flutter/services.dart';
import 'package:wisdom/src/data_models/daos/comment_list_dao.dart';
import 'package:wisdom/src/data_models/daos/fact_list_dao.dart';
import 'package:wisdom/src/data_models/daos/force_update_dao.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/data_source/repository.dart';
import 'package:http/http.dart' as http;
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

  @override
  Future<FactListDao> fetchListPaginated(int limit, int page) async {
    var url = Uri.parse('https://catfact.ninja/facts?limit=$limit&page=$page');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    return FactListDao.fromJson(data);
  }

  @override
  Future<FunListDao> getFunList() async {
    await Future.delayed(Duration(seconds: 3));
    final String response =
    await rootBundle.loadString('assets/jsons/fun_list.json');
    var data = json.decode(response);
    return FunListDao.fromJson(data);
  }

  @override
  Future<CommentListDao> getCommentList() async{
    final String response =
        await rootBundle.loadString('assets/jsons/comment_list.json');
    var data = json.decode(response);
    return CommentListDao.fromJson(data);  }

}
