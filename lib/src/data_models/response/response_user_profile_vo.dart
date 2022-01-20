import 'package:wisdom/src/app_utils/user_profile_generator.dart';

/// data : {"id":1,"nickname":"test","device_id":"1234567890","type":"normal","code":"testing123","created_at":"2022-01-09T09:31:37.000000Z","updated_at":"2022-01-09T09:31:37.000000Z","deleted_at":null}

class ResponseUserProfileVO {
  ResponseUserProfileVO({
      Data? data,}){
    _data = data;
}

  ResponseUserProfileVO.fromJson(dynamic json) {
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
/// nickname : "test"
/// device_id : "1234567890"
/// type : "normal"
/// code : "testing123"
/// created_at : "2022-01-09T09:31:37.000000Z"
/// updated_at : "2022-01-09T09:31:37.000000Z"
/// deleted_at : null

class Data {
  Data({
      int? id, 
      String? nickname, 
      String? deviceId, 
      String? type, 
      String? code, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _nickname = nickname;
    _deviceId = deviceId;
    _type = type;
    _code = code;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _nickname = json['nickname'];
    _deviceId = json['device_id'];
    _type = json['type'];
    _code = json['code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _profileUrl = TempProfileGenerator.getTempProfileUrl(_id);
  }


  int? _id;
  String? _nickname;
  String? _deviceId;
  String? _type;
  String? _code;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  String? _profileUrl;

  set setNickname(String value) {
    _nickname = value;
  }

  int? get id => _id;
  String? get nickname => _nickname;
  String? get deviceId => _deviceId;
  String? get type => _type;
  String? get code => _code;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get profileUrl => _profileUrl;
  dynamic get deletedAt => _deletedAt;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nickname'] = _nickname;
    map['device_id'] = _deviceId;
    map['type'] = _type;
    map['code'] = _code;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}