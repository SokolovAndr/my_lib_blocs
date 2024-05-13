import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));
String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  List<DataImage> dataImage;

  ImageModel({
    required this.dataImage,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        dataImage: List<DataImage>.from(
            json["data"].map((x) => DataImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(dataImage.map((x) => x.toJson())),
      };
}

class DataImage {
    int id;
    String name;
    String type;

    DataImage({
        required this.id,
        required this.name,
        required this.type,
    });

    factory DataImage.fromJson(Map<String, dynamic> json) => DataImage(
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
