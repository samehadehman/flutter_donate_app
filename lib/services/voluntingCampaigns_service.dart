import 'package:dio/dio.dart';
import 'package:hello/models/scheduledTask_model.dart';
import 'package:hello/models/voluntingCampaignDetails_model.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignService {
  final Dio _dio = Dio();

  Future<List<CampaignModel>> getAllCampaigns(String token) async {
    try {
      final response = await _dio.get(
        "http://192.168.28.158:8000/api/getAllVoluntingCampigns",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 1) {
        List campaigns = response.data['data'];
        return campaigns.map((e) => CampaignModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to fetch campaigns");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

   Future<CampaignDetailsModel> getCampaignDetails(int id , String token) async {
    final response = await _dio.get(
      "http://192.168.28.158:8000/api/getVoluntingCampigndetails/$id",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    if (response.statusCode == 200 && response.data['status'] == 1) {
  print("🚀 Full Response: ${response.data}");
    print("✅ Campaign Data: ${response.data['data'][0]}");
   
      return CampaignDetailsModel.fromJson(response.data['data'][0]);
    } else {
      throw Exception("Failed to load campaign details");
    }
  }

 Future<Task> getTaskDetails(int taskId, String token) async {
  try {
    final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token') ?? '';

    final response = await _dio.get(
      "http://192.168.28.158:8000/api/getTaskDetails/$taskId",
      options: Options(
        headers: {"Authorization": "Bearer $token" ,
        "Accept": "application/json"
        },
      validateStatus: (status) => true, // يسمح لكل status

      ),
    );

    print('Status Code: ${response.statusCode}');
    print('Raw Response: ${response.data}');

    if (response.statusCode == 200 && response.data['status'] == 1) {
      final taskJson = Map<String, dynamic>.from(response.data['data']);
      print('Task JSON: $taskJson');
      return Task.fromJson(taskJson);
    } else {
      throw Exception("فشل في جلب تفاصيل التاسك: ${response.data}");
    }
  } on DioException catch (e) {
    print("Dio Error → Status: ${e.response?.statusCode}");
    print("Dio Error → Data: ${e.response?.data}");
    print("Dio Error → Message: ${e.message}");
    throw Exception("API error: ${e.response?.statusCode}");
  } catch (e) {
    print("Unexpected Error: $e");
    rethrow;
  }
}


 Future<List<ScheduledTask>> getScheduledTasks(String token) async {

    final response = await _dio.get(
      "http://192.168.28.158:8000/api/upComingTasks",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (status) {
      // ✅ أي status code بين 200 و 500 خليه يرجع response عادي
      return status != null && status < 500;
    },
      ),
    );
print('Status Code: ${response.statusCode}');
print('Response Data: ${response.data}');

    if (response.statusCode == 200 && response.data['status'] == 1) {
      List<dynamic> data = response.data['data'];
      return data.map((taskJson) => ScheduledTask.fromJson(taskJson)).toList();
    }
    
    else if (response.statusCode == 401) {
 final message = response.data['message'] ?? "ليس لديك ملف تطوعي";
   print("🔥 Service 401 Message: $message");

  throw Exception(message);    }
     else {
      throw Exception("فشل في جلب المهام المجدولة");
    }
    

  }
}
