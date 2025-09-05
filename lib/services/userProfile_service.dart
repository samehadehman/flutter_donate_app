import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
    final String baseUrl = Url.url;
      final dio = Dio();



  Future<UserModel> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final response = await dio.get(
                '$baseUrl/miniIfo',


        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      if (response.statusCode == 200 && response.data['status'] == 1) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load user');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }
}
