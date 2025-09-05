
import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/login_model.dart';
import 'package:hello/models/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
    final String baseUrl = Url.url;

  final Dio dio = Dio();


  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) 
  
  
  async {
    try {
      final response = await dio.post(
        "$baseUrl/register",
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'phone': phone,
        },
      );
      
      print("dataaaaaaaa:${response.data}");
      final registerModel = RegisterModel.fromJson(response.data);
   
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', registerModel.data.token);
       if (registerModel.data.token != 0) {
        print("RRRRRRRRR.............. : ${registerModel.data.token}");
       
      }

      return registerModel.data.token;


      
    } catch (e) {
       print("eeeeeeeeeeeeee.......:$e");
      throw Exception('فشل التسجيل: ${_handleError(e)}');
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "$baseUrl/signin",
        data: {
          'email': email,
          'password': password,
        },
      );

      final loginModel = LoginModel.fromJson(response.data);

      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', loginModel.data.token);
       if (loginModel.data.token != 0) {
        print("savvvvvvvvvvvvvv.............. : ${loginModel.data.token}");
       
      }

      return loginModel.data.token;
      
    } catch (e) {
      print("eeeeeeeeeeeeee.......:$e");
      throw Exception('فشل تسجيل الدخول: ${_handleError(e)}');
    }
  }
  Future<String> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        "$baseUrl/userResetPassword/$code",
        data: {
          "email": email.trim(),
          "code": code.trim(),
          "password": newPassword.trim(),
          "password_confirmation": newPassword.trim(),
        },
        options: Options(
          headers: {"Accept": "application/json"},
        ),
      );

      print("Reset Password response: ${response.data}");

      if (response.statusCode == 200) {
        final token = response.data['data']['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print("تم حفظ التوكن بعد إعادة التعيين: $token");
        return token; // أو return response.data['message'] إذا تحب
      } else {
        throw Exception("فشل إعادة تعيين كلمة المرور");
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data["message"] ?? "خطأ غير متوقع");
    }
  }

  /// ✅ تابع تسجيل الخروج
  Future<String> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
  print("🔹 التوكن الحالي: $token");

      if (token == null || token.isEmpty) {
        throw Exception("لم يتم العثور على التوكن. المستخدم غير مسجل دخول.");
      }

      final response = await dio.get(
        "$baseUrl/logout",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print("Logout response: ${response.data}");

      // ✅ امسح التوكن من التخزين المحلي
      await prefs.remove('token');
    print("🔹 استجابة الخادم: ${response.data}");

      return response.data["message"] ?? "تم تسجيل الخروج بنجاح";
    } on DioError catch (e) {
      throw Exception(e.response?.data["message"] ?? "خطأ أثناء تسجيل الخروج");
    } catch (e) {
      throw Exception("خطأ غير متوقع أثناء تسجيل الخروج");
    }
  }
  String _handleError(Object error) {
    if (error is DioError) {
      try {
        return error.response?.data['message'] ??
            'حدث خطأ غير متوقع. حاول مجددًا.';
      } catch (_) {
        return 'فشل الاتصال بالخادم.';
      }
    }
    return 'حدث خطأ غير متوقع.';
  }
}