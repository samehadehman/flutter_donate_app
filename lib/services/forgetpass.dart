// lib/core/network/api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello/models/forgetpass_model.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api', // غيرها للـ API الحقيقي
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Future<ForgotPasswordModel> sendForgotPasswordEmail(String email) async {
    try {
      final response = await _dio.post(
        '/userForgotPassword', 
        data: {'email': email.trim()},
      );

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      }
// service
else if (response.statusCode == 422) {
      throw Exception("البريد الإلكتروني هذا غير موجود");

}

       else {
        throw Exception('فشل إرسال البريد الإلكتروني');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'حدث خطأ غير معروف');
      } else {
        throw Exception('تعذر الاتصال ');
      }
    }
  }

  static Future<VerifyCodeModel> verifyCode(String email, String code) async {
    try {
      final response = await _dio.post(
        '/userCheckCode',
        data: {
          'email': email.trim(),
          'code': code.trim(),
        },
      );

      if (response.statusCode == 200 ) {
        return VerifyCodeModel.fromJson(response.data);
      } else {
        throw Exception('فشل التحقق من الكود');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'حدث خطأ غير معروف');
      } else {
        throw Exception('تعذر الاتصال ');
      }
    }
  }
   static Future<ResetPasswordResponse> resetPassword(String code, String password) async {
    try {
      final response = await _dio.post(
        "/userResetPassword/$code",
        data: {
          "password": password,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ResetPasswordResponse.fromJson(response.data);
      } else {
        throw Exception("فشل إعادة تعيين كلمة المرور");
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data["message"] ?? "خطأ غير متوقع");
    }
  }
}