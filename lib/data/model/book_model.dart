import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));
String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  List<DataBook> dataBook;

  BookModel({
    required this.dataBook,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        dataBook:
            List<DataBook>.from(json["data"].map((x) => DataBook.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(dataBook.map((x) => x.toJson())),
      };
}

class DataBook {
    int id;
    String title;
    String description;
    int authorId;
    int genreId;
    int imageId;
    Ui autorUi;
    Ui genreUi;
    ImageUi imageUi;

    DataBook({
        required this.id,
        required this.title,
        required this.description,
        required this.authorId,
        required this.genreId,
        required this.imageId,
        required this.imageUi,
        required this.autorUi,
        required this.genreUi,
    });

    factory DataBook.fromJson(Map<String, dynamic> json) => DataBook(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        authorId: json["authorId"],
        genreId: json["genreId"],
        imageId: json["imageId"],
        imageUi: ImageUi.fromJson(json["imageUi"]),
        autorUi: Ui.fromJson(json["autorUi"]),
        genreUi: Ui.fromJson(json["genreUi"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "authorId": authorId,
        "genreId": genreId,
        "imageId": imageId,
        "imageUi": imageUi.toJson(),
        "autorUi": autorUi.toJson(),
        "genreUi": genreUi.toJson(),
    };
}

class Ui {
    int id;
    String name;

    Ui({
        required this.id,
        required this.name,
    });

    factory Ui.fromJson(Map<String, dynamic> json) => Ui(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class ImageUi {
    int id;
    String name;
    String type;

    ImageUi({
        required this.id,
        required this.name,
        required this.type,
    });

    factory ImageUi.fromJson(Map<String, dynamic> json) => ImageUi(
        id: json["id"],
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
    };
}
