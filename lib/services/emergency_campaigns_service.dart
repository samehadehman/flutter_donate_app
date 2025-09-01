import 'package:dio/dio.dart';
import 'package:hello/models/emergency_model.dart';

class EmergencyCampaignsService {
  final String baseUrl = 'http://192.168.207.158:8000/api';
  final Dio dio = Dio();

  Future<List<EmergencyCampaign>?> getEmergencyCampaigns(String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/emergencyCompaings', 
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Emergency Status: ${response.statusCode}');
      print('Emergency Data: ${response.data}');

      if (response.statusCode == 200) {
        final parsed = EmergencyCampaignsResponse.fromJson(response.data);
        return parsed.data;
      }
      return null;
    } catch (e) {
      print('Emergency Dio Error: $e');
      return null;
    }
  }
}
