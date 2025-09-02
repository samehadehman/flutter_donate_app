import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hello/models/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.28.158:8000/api";

  Future<UserInfo> getUserInfo(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await dio.get(
      '$baseUrl/showAllInfo',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );
    print("User data: ${response.data}");
    if (response.statusCode == 200 && response.data['status'] == 1) {
      return UserInfo.fromJson(response.data);
    } else {
      throw Exception("فشل جلب البيانات");
    }
  }

  Future<UserInfo> updateProfile({
    required String name,
    required String phone,
    required String? age,
    required int? gender,
    required int? city,
    // File? imageFile, // 👈 إضافة اختيارية للصورة
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "phone": phone,
      "age": age,
      "gender_id": gender,
      "city_id": city,
      //   if (imageFile != null)
      //     "photo": await MultipartFile.fromFile(imageFile.path, filename: "profile.png"),
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final res = await dio.post(
      "$baseUrl/editPersonalInfo",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    print("User received: ${res.data}");
    if (res.statusCode == 200 && res.data['status'] == 1) {
      final updatedUser = UserInfo.fromJson(res.data);
      return UserInfo(
        userName: updatedUser.userName,
        name: updatedUser.name,
        cityId: updatedUser.cityId,
        cityName: updatedUser.cityName,
        phone: phone,
        age: updatedUser.age,
        genderId: updatedUser.genderId,
        gender: updatedUser.gender,
        email: updatedUser.email,
        // photo: updatedUser.photo ?? updatedUser.photo,
      );
    } else {
      throw Exception(res.data['message'] ?? "فشل تحديث البيانات");
    }
  }
}
