class ResponseRegisterVO {
  String? _token;
  User? _user;

  ResponseRegisterVO({String? token, User? user}) {
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

  ResponseRegisterVO.fromJson(Map<String, dynamic> json) {
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
  String? _nickname;
  String? _deviceId;
  String? _code;
  String? _updatedAt;
  String? _createdAt;
  String? _firebaseToken;
  int? _id;

  User(
      {String? nickname,
      String? deviceId,
      String? code,
      String? updatedAt,
      String? createdAt,
      String? firebaseToken,
      int? id}) {
    if (nickname != null) {
      this._nickname = nickname;
    }
    if (deviceId != null) {
      this._deviceId = deviceId;
    }
    if (code != null) {
      this._code = code;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (id != null) {
      this._id = id;
    }

    if (_firebaseToken != null) {
      this._firebaseToken = firebaseToken;
    }
  }

  String? get nickname => _nickname;
  set nickname(String? nickname) => _nickname = nickname;
  String? get deviceId => _deviceId;
  set deviceId(String? deviceId) => _deviceId = deviceId;
  String? get code => _code;
  set code(String? code) => _code = code;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get firebaseToken => _firebaseToken;
  set firebaseToken(String? firebaseToken) => _firebaseToken = firebaseToken;
  int? get id => _id;
  set id(int? id) => _id = id;

  User.fromJson(Map<String, dynamic> json) {
    _nickname = json['nickname'];
    _deviceId = json['device_id'];
    _code = json['code'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _firebaseToken = json['firebase_token'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this._nickname;
    data['device_id'] = this._deviceId;
    data['code'] = this._code;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['firebase_token'] = this._firebaseToken;
    data['id'] = this._id;
    return data;
  }
}
