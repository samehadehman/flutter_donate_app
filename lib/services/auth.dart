// import 'package:dio/dio.dart';
// import 'package:donation/models/login_model.dart';
// import 'package:donation/models/register_model.dart';
// import 'package:get_it/get_it.dart';

// class AuthService {
//   // static Dio dio = GetIt.instance<Dio>();
//   final Dio dio =Dio();

//   final String baseUrl = "http://192.168.137.97:8000/api";

//   Future<String> register({
//     required String name,
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String phone,
//   }) async {
//     try {
//       final response = await dio.post(
//         "$baseUrl/register",
//         data: {
//           'name': name,
//           'email': email,
//           'password': password,
//           'password_confirmation': confirmPassword,
//           'phone': phone,
//         },
//       );

//       final registerModel = RegisterModel.fromJson(response.data);
//       return registerModel.message;
//     } catch (e) {
//       throw Exception('فشل التسجيل: $e');
      
//     }
    
//   }

//   Future<String> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await dio.post(
//         "$baseUrl/signin",
//         data: {
//           'email': email,
//           'password': password,
//         },
//       );

//       final loginModel = LoginModel.fromJson(response.data);
//       return loginModel.message;
//     } catch (e) {
//       throw Exception('فشل تسجيل الدخول: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:hello/models/login_model.dart';
import 'package:hello/models/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = Dio();
final String baseUrl = "http://127.0.0.1:8000/api";
//192.168.1.103 للجوال


AuthService() {
    // هنا نخلي Dio ما يرمي exception على status < 500
    dio.options.validateStatus = (status) => status != null && status < 500;
  }


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
      return registerModel.message;
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

      return loginModel.message;
      
    } catch (e) {
      print("eeeeeeeeeeeeee.......:$e");
      throw Exception('فشل تسجيل الدخول: ${_handleError(e)}');
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