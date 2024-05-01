import 'dart:convert';

GenreModel genreModelFromJson(String str) => GenreModel.fromJson(json.decode(str));
String genreModelToJson(GenreModel data) => json.encode(data.toJson());


class GenreModel {
  List<DataGenre> dataGenre;

  GenreModel({
    required this.dataGenre,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        dataGenre: List<DataGenre>.from(
            json["data"].map((x) => DataGenre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(dataGenre.map((x) => x.toJson())),
      };
}

class DataGenre {
  int id;
  String name;

  DataGenre({
    required this.id,
    required this.name,
  });

  factory DataGenre.fromJson(Map<String, dynamic> json) => DataGenre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

