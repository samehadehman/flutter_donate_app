import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/countAssociation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsService {
    final String baseUrl = Url.url;

  // final String baseUrl = 'http://192.168.137.134:8000/api';
  final Dio dio = Dio();

  Future<AssociationCountModel?> getAssociationCount(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final response = await dio.get(
        '$baseUrl/countAssociationsMob',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return AssociationCountModel.fromJson(response.data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Dio Error: $e');
      return null;
    }
  }
}


class InKindService {
    final String baseUrl = Url.url;

  // final String baseUrl = 'http://192.168.137.134:8000/api';
  final Dio dio = Dio();

  Future<TotalInkindDonation?> gettotalInkindDonations(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final response = await dio.get(
        '$baseUrl/totalInkindDonationsByYearMob',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return TotalInkindDonation.fromJson(response.data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Dio Error: $e');
      return null;
    }
  }
}

class DonationService {
  final String baseUrl = Url.url;
  final Dio dio = Dio();

  Future<DonationTotalModel?> getDonationTotal(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final response = await dio.get(
        '$baseUrl/totalDonationsByYearMob', // عدل الـ endpoint حسب الـ API
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Donation Status: ${response.statusCode}');
      print('Donation Data: ${response.data}');

      if (response.statusCode == 200) {
        return DonationTotalModel.fromJson(response.data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Dio Error: $e');
      return null;
    }
  }
}

class EndedCampaignsService {
  final String baseUrl = Url.url;
  final Dio dio = Dio();
  Future<EndedCampaignsModel?> getEndedCampaigns(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final response = await dio.get(
        '$baseUrl/getEndedCampaignsCountByYearMob',
        options: Options(
          responseType: ResponseType.plain,

          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('RAW RESPONSE >>> ${response.toString()}');
      print('DATA AS STRING >>> ${response.data.toString()}');

      if (response.statusCode == 200) {
        final rawString = response.data as String;
        final start = rawString.indexOf("{");
        final end = rawString.lastIndexOf("}");
        if (start != -1 && end != -1) {
          final cleaned = rawString.substring(start, end + 1);
          print("CLEANED JSON >>> $cleaned");
          final decoded = jsonDecode(cleaned);
          return EndedCampaignsModel.fromJson(decoded);
        } else {
          print("⚠️ ما لقيت JSON صحيح بالـ response");
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Dio Error: $e');
      return null;
    }
  }
}
