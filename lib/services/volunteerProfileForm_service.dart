import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class VolunteerService {
  final Dio _dio;

  VolunteerService(this._dio);

  Future<CreateVolunteerProfileResponse> createProfile(
    
      Map<String, dynamic> body) async {
        try{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    
    print("📤 Sending profile JSON: ${jsonEncode(body)}");

    final response = await _dio.post(
      "http://192.168.28.158:8000/api/createVoluntingProfile",
      options: Options(headers: {"Authorization": "Bearer $token"}),
      data: body,
    );
      print("📥 Received response: ${response.data}");

    return CreateVolunteerProfileResponse.fromJson(response.data);
    
  }
  on DioException catch (e) {
  print("🚨 DioException caught:");
  print("Status code: ${e.response?.statusCode}");
  print("Response data: ${e.response?.data}"); // 👈 هذا مهم جدًا
  print("Error message: ${e.message}");
  throw e;
}
      }

  Future<GetVolunteerProfileResponse> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await _dio.get(
      "http://192.168.28.158:8000/api/showVoluntingProfile",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
      print("📥 getProfile response: ${response.data}");

    return GetVolunteerProfileResponse.fromJson(response.data);
  }
Future<CreateVolunteerProfileResponse> getVolunteerDetailProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  try {
    final response = await _dio.get(
      "http://192.168.28.158:8000/api/showVoluntingProfileDetails", // ✅ endpoint الصحيح
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    print("📥 Volunteer detail response: ${response.data}"); // Debug

    return CreateVolunteerProfileResponse.fromJson(response.data);
  } on DioException catch (e) {
    print("🚨 DioException: ${e.response?.statusCode} => ${e.response?.data}");
    throw Exception(e.response?.data ?? e.message);
  } catch (e) {
    print("🚨 Unexpected error: $e");
    throw Exception("خطأ غير متوقع: $e");
  }
}


 Future<CreateVolunteerProfileResponse> updateVolunteerProfile(
      Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      print("📤 Sending update JSON: ${jsonEncode(body)}");

      final response = await _dio.put(
        "http://192.168.28.158:8000/api/updateVoluntingProfile", // ضع endpoint الصحيح
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: body,
      );

      print("📥 Update response: ${response.data}");

      return CreateVolunteerProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("🚨 DioException: ${e.response?.statusCode} => ${e.response?.data}");
      throw Exception(e.response?.data ?? e.message);
    } catch (e) {
      print("🚨 Unexpected error: $e");
      throw Exception("خطأ غير متوقع: $e");
    }
  }

}
