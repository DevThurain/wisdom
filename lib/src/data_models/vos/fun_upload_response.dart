/// data : {"id":5,"post":"Laked Matannng","date":"1 second ago","comment_count":0,"created_at":"2022-01-09T10:37:25.000000Z","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}}

class FunUploadResponse {
  FunUploadResponse({
      Data? data,}){
    _data = data;
}

  FunUploadResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 5
/// post : "Laked Matannng"
/// date : "1 second ago"
/// comment_count : 0
/// created_at : "2022-01-09T10:37:25.000000Z"
/// creator : {"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}

class Data {
  Data({
      int? id, 
      String? post, 
      String? date, 
      int? commentCount, 
      String? createdAt, 
      FunPostCreator? creator,}){
    _id = id;
    _post = post;
    _date = date;
    _commentCount = commentCount;
    _createdAt = createdAt;
    _creator = creator;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _post = json['post'];
    _date = json['date'];
    _commentCount = json['comment_count'];
    _createdAt = json['created_at'];
    _creator = json['creator'] != null ? FunPostCreator.fromJson(json['creator']) : null;
  }
  int? _id;
  String? _post;
  String? _date;
  int? _commentCount;
  String? _createdAt;
  FunPostCreator? _creator;

  int? get id => _id;
  String? get post => _post;
  String? get date => _date;
  int? get commentCount => _commentCount;
  String? get createdAt => _createdAt;
  FunPostCreator? get creator => _creator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['post'] = _post;
    map['date'] = _date;
    map['comment_count'] = _commentCount;
    map['created_at'] = _createdAt;
    if (_creator != null) {
      map['creator'] = _creator?.toJson();
    }
    return map;
  }

}

/// id : 1
/// nickname : "test"
/// code : "testing123"
/// device_id : "1234567890"
/// type : "normal"
/// ban : false
/// banned_by : null
/// deleted_by : null
/// deleted_at : null
/// created_at : "2022-01-09T03:01:37.000000Z"
/// updated_at : "2022-01-09T03:01:37.000000Z"

class FunPostCreator {
  FunPostCreator({
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
}

  FunPostCreator.fromJson(dynamic json) {
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