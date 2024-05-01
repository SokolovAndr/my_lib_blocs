import 'dart:convert';

AuthorModel authorModelFromJson(String str) =>
    AuthorModel.fromJson(json.decode(str));

String authorModelToJson(AuthorModel data) => json.encode(data.toJson());

String dataAuthorToJson(DataAuthor data2) => json.encode(data2.toJson());

class AuthorModel {
  List<DataAuthor> dataAuthor;

  AuthorModel({
    required this.dataAuthor,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        dataAuthor: List<DataAuthor>.from(
            json["data"].map((x) => DataAuthor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(dataAuthor.map((x) => x.toJson())),
      };
}

class DataAuthor {
  int id;
  String name;

  DataAuthor({
    required this.id,
    required this.name,
  });

  factory DataAuthor.fromJson(Map<String, dynamic> json) => DataAuthor(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

}
