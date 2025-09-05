
import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerService {
    final String baseUrl = Url.url;
      final dio = Dio();


  Future<CreateVolunteerProfileResponse> createProfile(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final res = await dio.post(
              '$baseUrl/createVoluntingProfile',

      options: Options(headers: {"Authorization": "Bearer $token"}),
      data: body,
    );
     print(res);
    return CreateVolunteerProfileResponse.fromJson(res.data);
  }

  Future<CreateVolunteerProfileResponse> updateProfile(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final res = await dio.post(
              '$baseUrl/updateVoluntingProfile',
 // إذا API عندك PUT أو PATCH غيريها
      options: Options(headers: {"Authorization": "Bearer $token"}),
      data: body,
    );
     print(res);
    return CreateVolunteerProfileResponse.fromJson(res.data);
  }

  Future<GetVolunteerProfileResponse> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final res = await dio.get(
              '$baseUrl/showVoluntingProfile',

      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    print(res);
    return GetVolunteerProfileResponse.fromJson(res.data);
  }


  Future<CreateVolunteerProfileResponse> getVolunteerDetailProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    try {
      final response = await dio.get(
                '$baseUrl/showVoluntingProfileDetails',

        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print(response);
      return CreateVolunteerProfileResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("خطأ في جلب تفاصيل الملف التطوعي: $e");
    }
  }


}
