import 'package:package_info_plus/package_info_plus.dart';

/// forceUpdate : {"versionName":"1.1.5","isForceUpdate":true,"isAlreadyUpdated":true,"storeUrl":"https://play.google.com/store/apps/details?id=com.tamron.akoneya","directDownloadUrl":"https://play.google.com/store/apps/details?id=com.tamron.akoneya"}

class ForceUpdateDao {
  ForceUpdateDao({
      ForceUpdate? forceUpdate,}){
    _forceUpdate = forceUpdate;
}

  ForceUpdateDao.fromJson(dynamic json) {
    _forceUpdate = json['forceUpdate'] != null ? ForceUpdate.fromJson(json['forceUpdate']) : null;
  }
  ForceUpdate? _forceUpdate;

  ForceUpdate? get forceUpdate => _forceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_forceUpdate != null) {
      map['forceUpdate'] = _forceUpdate?.toJson();
    }
    return map;
  }

}

/// versionName : "1.1.5"
/// isForceUpdate : true
/// isAlreadyUpdated : true
/// storeUrl : "https://play.google.com/store/apps/details?id=com.tamron.akoneya"
/// directDownloadUrl : "https://play.google.com/store/apps/details?id=com.tamron.akoneya"

class ForceUpdate {

  String? _versionName;
  bool? _isForceUpdate;
  String? _storeUrl;
  String? _directDownloadUrl;

  String? get versionName => _versionName;
  bool? get isForceUpdate => _isForceUpdate;
  String? get storeUrl => _storeUrl;
  String? get directDownloadUrl => _directDownloadUrl;

  ForceUpdate({
      String? versionName, 
      bool? isForceUpdate, 
      String? storeUrl,
      String? directDownloadUrl,}){
    _versionName = versionName;
    _isForceUpdate = isForceUpdate;
    _storeUrl = storeUrl;
    _directDownloadUrl = directDownloadUrl;
}

  ForceUpdate.fromJson(dynamic json) {
    _versionName = json['versionName'];
    _isForceUpdate = json['isForceUpdate'];
    _storeUrl = json['storeUrl'];
    _directDownloadUrl = json['directDownloadUrl'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['versionName'] = _versionName;
    map['isForceUpdate'] = _isForceUpdate;
    map['storeUrl'] = _storeUrl;
    map['directDownloadUrl'] = _directDownloadUrl;
    return map;
  }

}