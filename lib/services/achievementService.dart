import 'package:dio/dio.dart';
import 'package:hello/models/achievementSummary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementService {
  static Future<AchievementSummary?> fetchAchievementSummary() async {
    try {
   
      final dio = Dio();
 final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
    
      final response = await dio.get(
        'http://192.168.31.158:8000/api/mySummryAchievements',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 1 &&
            data['data'] is List &&
            data['data'].isNotEmpty) {
          return AchievementSummary.fromJson(data['data'][0]);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching achievements with Dio: $e');
      return null;
    }
  }
}
