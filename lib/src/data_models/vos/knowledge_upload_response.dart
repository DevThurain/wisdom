/// data : {"id":1,"note":"Hello Mate!","link":null,"date":"1 minute ago","created_at":"2022-01-09T12:24:30.000000Z","creator":{"id":1,"nickname":"Antimage","code":"testing123","device_id":"1234567890","type":"special","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T10:58:42.000000Z"}}

class KnowledgeUploadResponse {
  KnowledgeUploadResponse({
      Data? data,}){
    _data = data;
}

  KnowledgeUploadResponse.fromJson(dynamic json) {
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

/// id : 1
/// note : "Hello Mate!"
/// link : null
/// date : "1 minute ago"
/// created_at : "2022-01-09T12:24:30.000000Z"
/// creator : {"id":1,"nickname":"Antimage","code":"testing123","device_id":"1234567890","type":"special","ban":false,"banned_by":null,"deleted_by":null,"deleted_at":null,"created_at":"2022-01-09T03:01:37.000000Z","updated_at":"2022-01-09T10:58:42.000000Z"}

class Data {
  Data({
      int? id, 
      String? note, 
      dynamic link, 
      String? date, 
      String? createdAt, 
      KnowledgePostCreator? creator,}){
    _id = id;
    _note = note;
    _link = link;
    _date = date;
    _createdAt = createdAt;
    _creator = creator;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _note = json['note'];
    _link = json['link'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _creator = json['creator'] != null ? KnowledgePostCreator.fromJson(json['creator']) : null;
  }
  int? _id;
  String? _note;
  dynamic _link;
  String? _date;
  String? _createdAt;
  KnowledgePostCreator? _creator;

  int? get id => _id;
  String? get note => _note;
  dynamic get link => _link;
  String? get date => _date;
  String? get createdAt => _createdAt;
  KnowledgePostCreator? get creator => _creator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['note'] = _note;
    map['link'] = _link;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    if (_creator != null) {
      map['creator'] = _creator?.toJson();
    }
    return map;
  }

}

/// id : 1
/// nickname : "Antimage"
/// code : "testing123"
/// device_id : "1234567890"
/// type : "special"
/// ban : false
/// banned_by : null
/// deleted_by : null
/// deleted_at : null
/// created_at : "2022-01-09T03:01:37.000000Z"
/// updated_at : "2022-01-09T10:58:42.000000Z"

class KnowledgePostCreator {
  KnowledgePostCreator({
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

  KnowledgePostCreator.fromJson(dynamic json) {
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