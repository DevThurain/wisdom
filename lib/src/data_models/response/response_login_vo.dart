class ResponseLoginVO {
  String? _token;
  User? _user;

  ResponseLoginVO({String? token, User? user}) {
    if (token != null) {
      this._token = token;
    }
    if (user != null) {
      this._user = user;
    }
  }

  String? get token => _token;
  set token(String? token) => _token = token;
  User? get user => _user;
  set user(User? user) => _user = user;

  ResponseLoginVO.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    return data;
  }
}

class User {
  int? _id;
  String? _nickname;
  String? _code;
  String? _deviceId;
  String? _type;
  bool? _ban;
  Null? _bannedBy;
  Null? _deletedBy;
  Null? _deletedAt;
  String? _createdAt;
  String? _updatedAt;

  User(
      {int? id,
      String? nickname,
      String? code,
      String? deviceId,
      String? type,
      bool? ban,
      Null? bannedBy,
      Null? deletedBy,
      Null? deletedAt,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (nickname != null) {
      this._nickname = nickname;
    }
    if (code != null) {
      this._code = code;
    }
    if (deviceId != null) {
      this._deviceId = deviceId;
    }
    if (type != null) {
      this._type = type;
    }
    if (ban != null) {
      this._ban = ban;
    }
    if (bannedBy != null) {
      this._bannedBy = bannedBy;
    }
    if (deletedBy != null) {
      this._deletedBy = deletedBy;
    }
    if (deletedAt != null) {
      this._deletedAt = deletedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nickname => _nickname;
  set nickname(String? nickname) => _nickname = nickname;
  String? get code => _code;
  set code(String? code) => _code = code;
  String? get deviceId => _deviceId;
  set deviceId(String? deviceId) => _deviceId = deviceId;
  String? get type => _type;
  set type(String? type) => _type = type;
  bool? get ban => _ban;
  set ban(bool? ban) => _ban = ban;
  Null? get bannedBy => _bannedBy;
  set bannedBy(Null? bannedBy) => _bannedBy = bannedBy;
  Null? get deletedBy => _deletedBy;
  set deletedBy(Null? deletedBy) => _deletedBy = deletedBy;
  Null? get deletedAt => _deletedAt;
  set deletedAt(Null? deletedAt) => _deletedAt = deletedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  User.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nickname'] = this._nickname;
    data['code'] = this._code;
    data['device_id'] = this._deviceId;
    data['type'] = this._type;
    data['ban'] = this._ban;
    data['banned_by'] = this._bannedBy;
    data['deleted_by'] = this._deletedBy;
    data['deleted_at'] = this._deletedAt;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

