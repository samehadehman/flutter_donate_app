import 'package:dio/dio.dart';
import 'package:hello/models/forgetpass_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.207.158:8000/api',
    headers: {'Content-Type': 'application/json'},
  ));

  // إرسال طلب الفورغيت
  static Future<ForgotPasswordModel> sendForgotPasswordEmail(String email) async {
    final response = await _dio.post('/userForgotPassword', data: {'email': email.trim()});
    if (response.statusCode == 200) {
      return ForgotPasswordModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'فشل إرسال البريد الإلكتروني');
    }
  }

  // التحقق من الكود
  static Future<VerifyCodeModel> verifyCode(String email, String code) async {
    final response = await _dio.post('/userCheckCode', data: {'email': email.trim(), 'code': code.trim()});
    if (response.statusCode == 200) {
      return VerifyCodeModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'فشل التحقق من الكود');
    }
  }

  // إعادة تعيين الباسورد
  static Future<ResetPasswordResponse> resetPassword(String email, String code, String password) async {
    final response = await _dio.post(
      '/userResetPassword/$code',
      data: {
        'email': email.trim(),
        'code': code.trim(),
        'password': password.trim(),
        'password_confirmation': password.trim(),
      },
    );
    if (response.statusCode == 200) {
      final token = response.data['data']['token'] ?? '';
      if (token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }
      return ResetPasswordResponse.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'فشل إعادة تعيين كلمة المرور');
    }
  }
}

