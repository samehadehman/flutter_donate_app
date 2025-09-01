import 'package:dio/dio.dart';
import 'package:hello/models/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.207.158:8000/api',
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
      print('GET Wallet Response: ${response.data}');

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
    required double wallet_value,
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
      print('POST Wallet Response: ${response.data}');

      return response.statusCode == 200 && response.data['status'] == 1;
    } catch (e) {
      print('Error creating wallet: $e');
      return false;
    }
  }
}
