import 'package:wisdom/src/app_utils/user_profile_generator.dart';

/// data : [{"id":1,"note":"Hello Mate!","link":null,"date":"1 minute ago","created_at":"2022-01-09T12:24:30.000000Z","creator":{"id":1,"nickname":"Antimage","code":"testing123","device_id":"1234567890","type":"special","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T10:58:42.000000Z"}}]
/// links : {"first":"http://adsmob.test/mobile/wisdom/notes?page=1","last":"http://adsmob.test/mobile/wisdom/notes?page=1","prev":null,"next":null}
/// meta : {"current_page":1,"from":1,"last_page":1,"links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://adsmob.test/mobile/wisdom/notes?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"path":"http://adsmob.test/mobile/wisdom/notes","per_page":15,"to":1,"total":1}

class KnowledgeListVo {
  KnowledgeListVo({
      List<KnowledgeItem>? data,
      Links? links, 
      Meta? meta,}){
    _data = data;
    _links = links;
    _meta = meta;
}

  KnowledgeListVo.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(KnowledgeItem.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<KnowledgeItem>? _data;
  Links? _links;
  Meta? _meta;

  List<KnowledgeItem>? get knowledgeList => _data;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

/// current_page : 1
/// from : 1
/// last_page : 1
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://adsmob.test/mobile/wisdom/notes?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// path : "http://adsmob.test/mobile/wisdom/notes"
/// per_page : 15
/// to : 1
/// total : 1

class Meta {
  Meta({
      int? currentPage, 
      int? from, 
      int? lastPage, 
      String? path,
      int? perPage, 
      int? to, 
      int? total,}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
}

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  int? _from;
  int? _lastPage;
  String? _path;
  int? _perPage;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get path => _path;
  int? get perPage => _perPage;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// first : "http://adsmob.test/mobile/wisdom/notes?page=1"
/// last : "http://adsmob.test/mobile/wisdom/notes?page=1"
/// prev : null
/// next : null

class Links {
  Links({
      String? first, 
      String? last, 
      dynamic prev, 
      dynamic next,}){
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
}

  Links.fromJson(dynamic json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }
  String? _first;
  String? _last;
  dynamic _prev;
  dynamic _next;

  String? get first => _first;
  String? get last => _last;
  dynamic get prev => _prev;
  dynamic get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
    return map;
  }

}

/// id : 1
/// note : "Hello Mate!"
/// link : null
/// date : "1 minute ago"
/// created_at : "2022-01-09T12:24:30.000000Z"
/// creator : {"id":1,"nickname":"Antimage","code":"testing123","device_id":"1234567890","type":"special","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T10:58:42.000000Z"}

class KnowledgeItem {
  KnowledgeItem({
      int? id, 
      String? note, 
      String? date,
      String? createdAt, 
      KnowledgeCommentCreator? creator,}){
    _id = id;
    _note = note;
    _date = date;
    _createdAt = createdAt;
    _creator = creator;
}

  KnowledgeItem.fromJson(dynamic json) {
    _id = json['id'];
    _note = json['note'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _creator = json['creator'] != null ? KnowledgeCommentCreator.fromJson(json['creator']) : null;
  }
  int? _id;
  String? _note;
  String? _date;
  String? _createdAt;
  KnowledgeCommentCreator? _creator;
  int? get id => _id;
  String? get note => _note;
  String? get date => _date;
  String? get createdAt => _createdAt;
  KnowledgeCommentCreator? get creator => _creator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['note'] = _note;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    if (_creator != null) {
      map['creator'] = _creator?.toJson();
    }
    return map;
  }

}

class KnowledgeCommentCreator {
  KnowledgeCommentCreator({
      int? id, 
      String? nickname, 
      String? code, 
      String? deviceId, 
      String? type, 
      bool? ban, 
      dynamic bannedBy, 
      dynamic deletedBy, 
      dynamic deletedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _nickname = nickname;
    _code = code;
    _deviceId = deviceId;
    _type = type;
    _ban = ban;
    _bannedBy = bannedBy;
    _deletedBy = deletedBy;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _profileAssetsUrl = TempProfileGenerator.getTempProfileUrl(_id);
  }

  KnowledgeCommentCreator.fromJson(dynamic json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _code = json['code'];
    _deviceId = json['device_id'];
    _type = json['type'];
    _ban = json['ban'];
    _bannedBy = json['banned_by'];
    _deletedBy = json['deleted_by'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _profileAssetsUrl = TempProfileGenerator.getTempProfileUrl(_id);

  }
  int? _id;
  String? _nickname;
  String? _code;
  String? _deviceId;
  String? _type;
  bool? _ban;
  dynamic _bannedBy;
  dynamic _deletedBy;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;
  String? _profileAssetsUrl;


  int? get id => _id;
  String? get nickname => _nickname;
  String? get code => _code;
  String? get deviceId => _deviceId;
  String? get type => _type;
  bool? get ban => _ban;
  dynamic get bannedBy => _bannedBy;
  dynamic get deletedBy => _deletedBy;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String get profileAssetsUrl =>
      _profileAssetsUrl ?? "assets/images/user_profile/ic_age_bulk.jpeg";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nickname'] = _nickname;
    map['code'] = _code;
    map['device_id'] = _deviceId;
    map['type'] = _type;
    map['ban'] = _ban;
    map['banned_by'] = _bannedBy;
    map['deleted_by'] = _deletedBy;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}