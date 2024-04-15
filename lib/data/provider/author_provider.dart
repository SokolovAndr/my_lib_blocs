import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:my_lib_blocs/data/model/author_model.dart';


class AuthorProvider {
  Future<bool> addAuthorService(String name) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://10.0.2.2:5080/Autor"),
          body: json.encode({'name': name}),
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
  Future<AuthorModel> readAuthorService() async {
    try {
      final response = await _dio.get("Autor");
      return userModelFromJson(response.toString());
    } catch (e) {
      debugPrint("Error $e");
      throw Exception(e);
    }
  }

  Future<bool> updateAuthorService(String id, String name) async {
    try {
      http.Response response = await http.put(
          Uri.parse("http://10.0.2.2:5080/Autor/$id"),
          body: json.encode({"id": id, "name": name}),
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

  Future<bool> deleteAuthorService(String id) async {
    try {
      http.Response response = await http.delete(
          Uri.parse("http://10.0.2.2:5080/Autor/$id"),
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
