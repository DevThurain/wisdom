import 'package:wisdom/src/app_utils/user_profile_generator.dart';

/// data : [{"id":4,"post":"I am fking genius.","date":"6 minutes ago","comment_count":0,"created_at":"2022-01-09T10:22:05.000000Z","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":3,"post":"I am fking genius.","date":"7 minutes ago","comment_count":0,"created_at":"2022-01-09T10:21:28.000000Z","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":2,"post":"Hello Mate","date":"9 minutes ago","comment_count":0,"created_at":"2022-01-09T10:19:23.000000Z","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}},{"id":1,"post":"wtf","date":"4 hours ago","comment_count":0,"created_at":"2022-01-09T06:03:30.000000Z","creator":{"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}}]
/// links : {"first":"http://adsmob.test/mobile/wisdom/posts?page=1","last":"http://adsmob.test/mobile/wisdom/posts?page=1","prev":null,"next":null}
/// meta : {"current_page":1,"from":1,"last_page":1,"links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://adsmob.test/mobile/wisdom/posts?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"path":"http://adsmob.test/mobile/wisdom/posts","per_page":15,"to":4,"total":4}

class PostListVo {
  PostListVo({
    List<FunItem>? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  PostListVo.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FunItem.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<FunItem>? _data;
  Meta? _meta;

  List<FunItem>? get funList => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
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
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://adsmob.test/mobile/wisdom/posts?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// path : "http://adsmob.test/mobile/wisdom/posts"
/// per_page : 15
/// to : 4
/// total : 4

class Meta {
  Meta({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Links>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) {
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }

  int? _currentPage;
  int? _from;
  int? _lastPage;
  List<Links>? _links;
  String? _path;
  int? _perPage;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;

  int? get from => _from;

  int? get lastPage => _lastPage;

  List<Links>? get links => _links;

  String? get path => _path;

  int? get perPage => _perPage;

  int? get to => _to;

  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  Links({
    dynamic url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;

  String? get label => _label;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

/// id : 4
/// post : "I am fking genius."
/// date : "6 minutes ago"
/// comment_count : 0
/// created_at : "2022-01-09T10:22:05.000000Z"
/// creator : {"id":1,"nickname":"test","code":"testing123","device_id":"1234567890","type":"normal","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T03:01:37.000000Z"}

class FunItem {
  FunItem({
    int? id,
    String? post,
    String? date,
    int? commentCount,
    String? createdAt,
    Creator? creator,
  }) {
    _id = id;
    _post = post;
    _date = date;
    _commentCount = commentCount;
    _createdAt = createdAt;
    _creator = creator;
  }

  FunItem.fromJson(dynamic json) {
    _id = json['id'];
    _post = json['post'];
    _date = json['date'];
    _commentCount = json['comment_count'];
    _createdAt = json['created_at'];
    _creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
  }

  int? _id;
  String? _post;
  String? _date;
  int? _commentCount;
  String? _createdAt;
  Creator? _creator;

  int? get id => _id;

  String? get post => _post;

  String? get date => _date;

  int? get commentCount => _commentCount;

  String? get createdAt => _createdAt;

  Creator? get creator => _creator;

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
    String? updatedAt,
  }) {
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
