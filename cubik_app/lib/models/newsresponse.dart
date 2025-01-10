import 'dart:convert';

import 'package:cubik_app/models/article.dart';

class NewsResponse {
    String status;
    int totalResults;
    List<Article> articles;

    NewsResponse({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory NewsResponse.fromJson(String str) => NewsResponse.fromMap(json.decode(str));

    factory NewsResponse.fromMap(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
    );
}


class Source {
    Id? id;
    String name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

    factory Source.fromMap(Map<String, dynamic> json) => Source(
      id: json["id"] != null ? idValues.map[json["id"]] : null,
      name: json["name"],
    );
}

enum Id {
    EL_MUNDO,
    IGN,
    MARCA,
    RT
}

final idValues = EnumValues({
    "el-mundo": Id.EL_MUNDO,
    "ign": Id.IGN,
    "marca": Id.MARCA,
    "rt": Id.RT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
