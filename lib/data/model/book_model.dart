import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  List<Data> data;

  BookModel({
    required this.data,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  int id;
  String title;
  String description;
  int authorId;
  int genreId;

  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.genreId
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      authorId: json["authorId"],
      genreId: json["genreId"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description":description,
        "authorId": authorId,
        "genreId": genreId
      };
}
