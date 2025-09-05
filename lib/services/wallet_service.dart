import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Url.url,
    headers: {'Accept': 'application/json'},
  ));

  Future<WalletModel?> getWallet(String token) async {
    try {
      final response = await _dio.get(
        '/showWallet',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true, 
        ),
      );

      print('GET Wallet Status: ${response.statusCode}');
      print('GET Wallet Response: ${response}');

      if (response.statusCode == 200 && response.data['status'] == 1) {
        return WalletModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      print('Error fetching wallet: $e');
      return null;
    }
  }

  // إنشاء المحفظة
  Future<bool> createWallet({
    required int wallet_value,
    required String wallet_password,
    required String wallet_password_confirmation,
  }) async {
 final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';    if (token == null) throw Exception("Token not found");

    try {
      final response = await _dio.post(
        '/createWallet',
        data: {
          'wallet_value': wallet_value,
          'wallet_password': wallet_password,
          'wallet_password_confirmation': wallet_password_confirmation,
        },
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          validateStatus: (_) => true,
        ),
      );

      print('POST Wallet Status: ${response.statusCode}');
      print('POST Wallet Response: ${response}');

      return response.statusCode == 200 && response.data['status'] == 1;
    } catch (e) {
      print('Error creating wallet: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> updateWallet({
  required int wallet_value,

}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  if (token.isEmpty) throw Exception("Token not found");

  try {
    final response = await _dio.post(
      '/editWallet', // رابط تعديل المحفظة عندك بالـ API
      data: {
        'wallet_value': wallet_value.toString(),

      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (_) => true,
      ),
    );

    print('PUT Wallet Status: ${response.statusCode}');
    print('PUT Wallet Response: ${response.data}');

 if (response.statusCode == 200) {
      return response.data; // بيرجع JSON كامل فيه status و message
    }
 return null;
      } catch (e) {
    print('Error updating wallet: $e');
  }
 
}




}
