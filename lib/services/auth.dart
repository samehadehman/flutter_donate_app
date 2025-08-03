import 'package:dio/dio.dart';
import 'package:hello/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-backend-url.com/api', 
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<bool> login({required UserModel userModel}) async {
    try {
      Response response = await dio.post(
        '/login', //endpoint تسجيل الدخول الخاص بك
        data: {
          "email": userModel.email,
          "password": userModel.password,
       
        },
      );

      if (response.statusCode == 200) {
        // استخرج التوكن من response حسب API الخاص بك
        String token = response.data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return true;
      } else {
        print("خطأ في تسجيل الدخول: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.data ?? e.message}");
      return false;
    } catch (e) {
      print("خطأ غير متوقع: $e");
      return false;
    }
  }


  Future<bool> signup({required UserModel userModel}) async {
  try {
    Response response = await dio.post(
      '/signup', // endpoint تسجيل الحساب الخاص بك
      data: userModel.toMap(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      String token = response.data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return true;
    } else {
      print("خطأ في إنشاء الحساب: ${response.statusCode}");
      return false;
    }
  } on DioException catch (e) {
    print("DioException أثناء إنشاء الحساب: ${e.response?.data ?? e.message}");
    return false;
  } catch (e) {
    print("خطأ غير متوقع أثناء إنشاء الحساب: $e");
    return false;
  }
}

}
