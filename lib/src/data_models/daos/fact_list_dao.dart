


// To parse this JSON data, do
//
//     final factListDao = factListDaoFromJson(jsonString);

import 'dart:convert';

FactListDao factListDaoFromJson(String str) => FactListDao.fromJson(json.decode(str));

String factListDaoToJson(FactListDao data) => json.encode(data.toJson());

class FactListDao {
    FactListDao({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    final int? currentPage;
    final List<Datum>? data;
    final String firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final String? nextPageUrl;
    final String? path;
    final String? perPage;
    final String? prevPageUrl;
    final int? to;
    final int? total;

    factory FactListDao.fromJson(Map<String, dynamic> json) => FactListDao(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null ? null : json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
    };
}

class Datum {
    Datum({
        required this.fact,
        required this.length,
    });

    final String? fact;
    final int? length;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fact: json["fact"] == null ? null : json["fact"],
        length: json["length"] == null ? null : json["length"],
    );

    Map<String, dynamic> toJson() => {
        "fact": fact == null ? null : fact,
        "length": length == null ? null : length,
    };
}

class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    final String? url;
    final String? label;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
    };
}
