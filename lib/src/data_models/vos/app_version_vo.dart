class AppVersionVo {
  int? _id;
  int? _appId;
  String? _version;
  bool? _forceUpdate;
  String? _os;
  String? _storeURL;
  String? _directURL;
  dynamic? _deletedBy;
  dynamic? _deletedAt;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get appId => _appId;
  String? get version => _version;
  bool? get forceUpdate => _forceUpdate;
  String? get os => _os;
  String? get storeURL => _storeURL;
  String? get directURL => _directURL;
  dynamic? get deletedBy => _deletedBy;
  dynamic? get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  AppVersionVo({
      int? id, 
      int? appId, 
      String? version, 
      bool? forceUpdate, 
      String? os, 
      String? storeURL, 
      String? directURL, 
      dynamic? deletedBy, 
      dynamic? deletedAt, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _appId = appId;
    _version = version;
    _forceUpdate = forceUpdate;
    _os = os;
    _storeURL = storeURL;
    _directURL = directURL;
    _deletedBy = deletedBy;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  AppVersionVo.fromJson(dynamic json) {
    _id = json['id'];
    _appId = json['app_id'];
    _version = json['version'];
    _forceUpdate = json['force_update'];
    _os = json['os'];
    _storeURL = json['storeURL'];
    _directURL = json['directURL'];
    _deletedBy = json['deleted_by'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['app_id'] = _appId;
    map['version'] = _version;
    map['force_update'] = _forceUpdate;
    map['os'] = _os;
    map['storeURL'] = _storeURL;
    map['directURL'] = _directURL;
    map['deleted_by'] = _deletedBy;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}