import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/myvolounting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyVolunteerService {
    final String baseUrl = Url.url;



  Future<List<Volunteer>> fetchVolunteers() async {
    try {
            final dio = Dio();

 final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';  
          final response = await dio.get(
                '$baseUrl/myVoluntings',

        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 1) {
        final List data = response.data['data'];
        return data.map((e) => Volunteer.fromJson(e)).toList();
      } else {
        throw Exception('فشل تحميل التطوعات');
      }
    } catch (e) {
      throw Exception('خطأ: $e');
    }
  }
}
