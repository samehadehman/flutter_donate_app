import 'package:dio/dio.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class VolunteerService {
  final Dio _dio;

  VolunteerService(this._dio);

  Future<CreateVolunteerProfileResponse> createProfile(
    
      Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await _dio.post(
      "http://192.168.207.158:8000/api/createVoluntingProfile",
      options: Options(headers: {"Authorization": "Bearer $token"}),
      data: body,
    );

    return CreateVolunteerProfileResponse.fromJson(response.data);
  }

  Future<GetVolunteerProfileResponse> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await _dio.get(
      "http://192.168.207.158:8000/api/showVoluntingProfile",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return GetVolunteerProfileResponse.fromJson(response.data);
  }

  Future<GetVolunteerProfileResponse> getProfileDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await _dio.get(
      "http://192.168.207.158:8000/api/showVoluntingProfileDetails",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return GetVolunteerProfileResponse.fromJson(response.data);
  }
}
