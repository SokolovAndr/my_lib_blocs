import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:my_lib_blocs/data/model/book_model.dart';

class BookProvider {
  Future<bool> addBookService(String title, String description, String authorId, String genreId) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://10.0.2.2:5080/Book"),
          body: json.encode({"title": title, "description": description, "authorId":authorId, "genreId": genreId}),
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
  Future<BookModel> readBookService() async {
    try {
      final response = await _dio.get("Book");
      return bookModelFromJson(response.toString());
    } catch (e) {
      debugPrint("Error $e");
      throw Exception(e);
    }
  }

  Future<bool> updateBookService(String id, String title, String description, String authorId, String genreId) async {
    try {
      http.Response response = await http.put(
          Uri.parse("http://10.0.2.2:5080/Book/$id"),
          body: json.encode({"id": id, "title": title, "description": description, "authorId":authorId, "genreId": genreId}),
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

  Future<bool> deleteBookService(String id) async {
    try {
      http.Response response = await http.delete(
          Uri.parse("http://10.0.2.2:5080/Book/$id"),
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
