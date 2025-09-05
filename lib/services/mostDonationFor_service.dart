import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/mostDonationFor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImpactCampaignService {
      final dio = Dio();
  final String baseUrl = Url.url;


  Future<List<ImpactCampaign>> fetchImpactCampaigns() async {
    try {
 final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';     
       final response = await dio.get(
        '$baseUrl/mostDonationFor',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 1) {
        final List data = response.data['data'];
        return data.map((e) => ImpactCampaign.fromJson(e)).toList();
      } else {
        throw Exception("فشل تحميل الحملات الأكثر تأثيراً");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
