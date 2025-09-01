
import 'package:dio/dio.dart';
import 'package:hello/models/login_model.dart';
import 'package:hello/models/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = Dio();
final String baseUrl = "http://192.168.207.158:8000/api";


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