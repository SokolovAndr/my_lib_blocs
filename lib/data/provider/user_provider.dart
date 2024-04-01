import 'package:dio/dio.dart';
import '../model/user_model.dart';

class UserProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://reqres.in/api/"));

  Future<UserModel> getUsers() async {
    try {
      final response = await _dio.get("users?page=1");
      return userModelFromJson(response.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
