// To parse this JSON data, do
//
//     final forceUpdateDao = forceUpdateDaoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ForceUpdateDao forceUpdateDaoFromJson(String str) => ForceUpdateDao.fromJson(json.decode(str));

String forceUpdateDaoToJson(ForceUpdateDao data) => json.encode(data.toJson());

class ForceUpdateDao {
    ForceUpdateDao({
        required this.update,
    });

    final List<Update>? update;

    factory ForceUpdateDao.fromJson(Map<String, dynamic> json) => ForceUpdateDao(
        update: json["update"] == null ? null : List<Update>.from(json["update"].map((x) => Update.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "update": update == null ? null : List<dynamic>.from(update!.map((x) => x.toJson())),
    };
}

class Update {
    Update({
        required this.id,
        required this.version,
        required this.forceUpdate,
        required this.osType,
        required this.storeUrl,
        required this.directUrl,
    });

    final int? id;
    final String? version;
    final bool? forceUpdate;
    final int? osType;
    final String? storeUrl;
    final String? directUrl;

    factory Update.fromJson(Map<String, dynamic> json) => Update(
        id: json["id"] == null ? null : json["id"],
        version: json["version"] == null ? null : json["version"],
        forceUpdate: json["force_update"] == null ? null : json["force_update"],
        osType: json["os_type"] == null ? null : json["os_type"],
        storeUrl: json["store_url"] == null ? null : json["store_url"],
        directUrl: json["direct_url"] == null ? null : json["direct_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "version": version == null ? null : version,
        "force_update": forceUpdate == null ? null : forceUpdate,
        "os_type": osType == null ? null : osType,
        "store_url": storeUrl == null ? null : storeUrl,
        "direct_url": directUrl == null ? null : directUrl,
    };
}
