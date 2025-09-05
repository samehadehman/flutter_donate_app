import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/cities_model.dart';

class CityService {
  final Dio dio = Dio();
    final String baseUrl = Url.url;

  // final String baseUrl = "http://192.168.82.158:8000/api";

  Future<List<City>> fetchCities() async {
    try {
      final response = await dio.get("$baseUrl/getCities");
      if (response.statusCode == 200) {
        final data = response.data['data']['cities'] as List;
        return data.map((json) => City.fromJson(json)).toList();
      } else {
        throw Exception("فشل جلب المدن");
      }
    } catch (e) {
      throw Exception("خطأ: $e");
    }
  }
}
