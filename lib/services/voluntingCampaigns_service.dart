import 'package:dio/dio.dart';
import 'package:hello/core/url.dart';
import 'package:hello/models/scheduledTask_model.dart';
import 'package:hello/models/voluntingCampaignDetails_model.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignService {
    final String baseUrl = Url.url;

  final Dio _dio = Dio();

  Future<List<CampaignModel>> getAllCampaigns(String token) async {
    try {
      final response = await _dio.get(
                '$baseUrl/getAllVoluntingCampigns',

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
              '$baseUrl/getVoluntingCampigndetails/$id',

    
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
   final pref = await SharedPreferences.getInstance();
   final savedTaskId = prefs.getInt('task_id') ?? 0;
    print('$savedTaskId');
    final response = await _dio.get(
              '$baseUrl/getTaskDetails/$taskId',

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
print("Raw response data: ${response.data}");

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

Future<String> volunteerForTask(int taskId, String token) async {
try{
 final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token') ?? '';

    final response = await _dio.get(
              '$baseUrl/voluntingRequest/$taskId',

      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

     print("🚀 volunteerForTask: ${response.data}");
   // print("✅ volunteerForTask: ${response.data['data'][0]}");
        if (response.statusCode == 200 && response.data != null) {

    return response.data['message'] ?? "تم إرسال طلبك للمراجعة";}

    
    else{
            return "فشل إرسال الطلب";

    }
}catch(e){
    return "خطأ أثناء إرسال الطلب: $e";
}
  }

 Future<List<ScheduledTask>> getScheduledTasks(String token) async {
 final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token') ?? '';
    final response = await _dio.get(
              '$baseUrl/upComingTasks',

      options: Options(
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (status) {
      // ✅ أي status code بين 200 و 500 خليه يرجع response عادي
      return status != null && status < 500;
    },
      ),
    );
  print('Status Code: ${response.statusCode}');
  print("📥 ScheduledTasks API raw response: ${response.data}");

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


  Future<TaskStatusModel> updateTaskStatus({
  required int taskId,
  // required String token,
  required int statusId,
}) async {
   final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token') ?? '';
  final response = await _dio.post(
            '$baseUrl/editTaskStatus/$taskId',

    data: {"status_id": statusId},
    options: Options(
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    ),
  );

  if (response.statusCode == 200 && response.data["status"] == 1) {
    return TaskStatusModel.fromJson(response.data["data"]);
  } else {
    throw Exception("فشل تعديل حالة المهمة: ${response.data}");
  }
}

}
