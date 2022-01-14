/// data : {"id":3,"post_id":2,"date":"1 second ago","created_at":"2022-01-09T10:52:24.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}}

class CommentResponseVo {
  CommentResponseVo({
      Comment? data,}){
    _data = data;
}

  CommentResponseVo.fromJson(dynamic json) {
    _data = json['data'] != null ? Comment.fromJson(json['data']) : null;
  }
  Comment? _data;

  Comment? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 3
/// post_id : 2
/// date : "1 second ago"
/// created_at : "2022-01-09T10:52:24.000000Z"
/// comment : "What's up"
/// creator : {"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}

class Comment {
  Comment({
      int? id, 
      int? postId, 
      String? date, 
      String? createdAt, 
      String? comment, 
      Creator? creator,}){
    _id = id;
    _postId = postId;
    _date = date;
    _createdAt = createdAt;
    _comment = comment;
    _creator = creator;
}

  Comment.fromJson(dynamic json) {
    _id = json['id'];
    _postId = json['post_id'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _comment = json['comment'];
    _creator = json['creator'] != null ? Creator.fromJson(json['creator']) : null;
  }
  int? _id;
  int? _postId;
  String? _date;
  String? _createdAt;
  String? _comment;
  Creator? _creator;

  int? get id => _id;
  int? get postId => _postId;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get comment => _comment;
  Creator? get creator => _creator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['post_id'] = _postId;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['comment'] = _comment;
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

class Creator {
  Creator({
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

  Creator.fromJson(dynamic json) {
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