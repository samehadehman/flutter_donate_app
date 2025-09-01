import 'package:dio/dio.dart';
import 'package:hello/models/mydonation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDonationService {
  final Dio dio;

  MyDonationService({required this.dio});

  Future<List<Donation>>fetchDonations() async {
    try {
 final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';      final response = await dio.get(
        'http://192.168.207.158:8000/api/mydonations',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 1) {
        final List data = response.data['data'];
        return data.map((e) => Donation.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load donations');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
