import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:my_lib_blocs/data/model/image_model.dart';

class MyImageProvider {
  Future<bool> addImageService(String name, String type) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://10.0.2.2:5080/Image"),
          body: json.encode({'name': name, 'type': type}),
          headers: {'Content-Type': 'application/json'});
      debugPrint("Response body: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:5080/"));
  Future<ImageModel> readImageService() async {
    try {
      final response = await _dio.get("Image");
      return imageModelFromJson(response.toString());
    } catch (e) {
      debugPrint("Error $e");
      throw Exception(e);
    }
  }

  Future<bool> updateImageService(String id, String name, String type) async {
    try {
      http.Response response = await http.put(
          Uri.parse("http://10.0.2.2:5080/Image/$id"),
          body: json.encode({"id": id, "name": name, "type": type}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        debugPrint("statusCode ${response.statusCode.toString()}");
        return true;
      } else {
        debugPrint(response.statusCode.toString());
        return false;
      }
    } catch (err) {
      debugPrint("Error $err");
      throw Exception(err);
    }
  }

  Future<bool> deleteImageService(String id) async {
    try {
      http.Response response = await http.delete(
          Uri.parse("http://10.0.2.2:5080/Image/$id"),
          body: {"id": id});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err);
    }
  }
}
