import 'dart:convert';

AuthorModel userModelFromJson(String str) => AuthorModel.fromJson(json.decode(str));

String userModelToJson(AuthorModel data) => json.encode(data.toJson());

class AuthorModel {
    List<Data> data;

    AuthorModel({
        required this.data,
    });

    factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    int id;
    String name;

    Data({
        required this.id,
        required this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
