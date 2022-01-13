import 'package:wisdom/src/app_utils/user_profile_generator.dart';

/// data : {"id":2,"post":"Hello Mate","date":"34 minutes ago","comment_count":3,"created_at":"2022-01-09T10:19:23.000000Z","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"},"comments":[{"id":1,"post_id":2,"date":"2 minutes ago","created_at":"2022-01-09T10:50:56.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":2,"post_id":2,"date":"2 minutes ago","created_at":"2022-01-09T10:51:19.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":3,"post_id":2,"date":"1 minute ago","created_at":"2022-01-09T10:52:24.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}}]}

class FunDetailVo {
  FunDetailVo({
      Data? data,}){
    _data = data;
}

  FunDetailVo.fromJson(dynamic json) {
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

/// id : 2
/// post : "Hello Mate"
/// date : "34 minutes ago"
/// comment_count : 3
/// created_at : "2022-01-09T10:19:23.000000Z"
/// creator : {"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}
/// comments : [{"id":1,"post_id":2,"date":"2 minutes ago","created_at":"2022-01-09T10:50:56.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":2,"post_id":2,"date":"2 minutes ago","created_at":"2022-01-09T10:51:19.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":3,"post_id":2,"date":"1 minute ago","created_at":"2022-01-09T10:52:24.000000Z","comment":"What's up","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}}]

class Data {
  Data({
      int? id, 
      String? post, 
      String? date, 
      int? commentCount, 
      String? createdAt,
    PostCreator? creator,
      List<Comments>? comments,}){
    _id = id;
    _post = post;
    _date = date;
    _commentCount = commentCount;
    _createdAt = createdAt;
    _creator = creator;
    _comments = comments;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _post = json['post'];
    _date = json['date'];
    _commentCount = json['comment_count'];
    _createdAt = json['created_at'];
    _creator = json['creator'] != null ? PostCreator.fromJson(json['creator']) : null;
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comments.fromJson(v));
      });
    }
  }
  int? _id;
  String? _post;
  String? _date;
  int? _commentCount;
  String? _createdAt;
  PostCreator? _creator;
  List<Comments>? _comments;

  int? get id => _id;
  String? get post => _post;
  String? get date => _date;
  int? get commentCount => _commentCount;
  String? get createdAt => _createdAt;
  PostCreator? get creator => _creator;
  List<Comments>? get comments => _comments;

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
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// post_id : 2
/// date : "2 minutes ago"
/// created_at : "2022-01-09T10:50:56.000000Z"
/// comment : "What's up"
/// creator : {"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}

class Comments {
  Comments({
      int? id, 
      int? postId, 
      String? date, 
      String? createdAt, 
      String? comment, 
      CommentCreator? creator,}){
    _id = id;
    _postId = postId;
    _date = date;
    _createdAt = createdAt;
    _comment = comment;
    _creator = creator;
}

  Comments.fromJson(dynamic json) {
    _id = json['id'];
    _postId = json['post_id'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _comment = json['comment'];
    _creator = json['creator'] != null ? CommentCreator.fromJson(json['creator']) : null;
  }
  int? _id;
  int? _postId;
  String? _date;
  String? _createdAt;
  String? _comment;
  CommentCreator? _creator;

  int? get id => _id;
  int? get postId => _postId;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get comment => _comment;
  CommentCreator? get creator => _creator;

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

class PostCreator {
  PostCreator({
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

  PostCreator.fromJson(dynamic json) {
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

class CommentCreator {
  CommentCreator({
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

  CommentCreator.fromJson(dynamic json) {
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
    _updatedAt = json['updated_at'];
    _profileAssetsUrl = profileAssetsUrlList["$_id".length - 1];
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
  String get profileAssetsUrl => _profileAssetsUrl ?? "assets/images/user_profile/ic_age_bulk.jpeg";

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