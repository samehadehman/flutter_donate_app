import 'package:dio/dio.dart';
import 'package:hello/models/search.dart';

class SearchService {
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.123.158:8000/api/searchCampaigns";

  Future<List<Campaign>> searchCampaigns(String classification, String token) async {
    try {
      print("🔍 searchCampaigns called with: $classification, token: $token");

      final response = await _dio.post(
        baseUrl,
        data: {
          "classification_name": classification,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer 12|7KrFj7rrM1bqhS0x1cT7YWqeDC1WtN7iXvdIYhs3a7e70135",
          },
        ),
      );

      print("📦 Response status: ${response.statusCode}");
      print("📄 Response data: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        final List campaigns = data["data"];
        return campaigns.map((json) => Campaign.fromJson(json)).toList();
      } else {
        throw Exception("فشل البحث: ${response.statusMessage}");
      }
    } catch (e) {
      print("❌ Error in service: $e");
      throw Exception("خطأ بالاتصال: $e");
    }
  }
}
