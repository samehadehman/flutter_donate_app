import 'package:dio/dio.dart';
import 'package:hello/models/scheduledTask_model.dart';
import 'package:hello/models/voluntingCampaignDetails_model.dart';
import 'package:hello/models/voluntingCampaigns_model.dart';

class CampaignService {
  final Dio _dio = Dio();

  Future<List<CampaignModel>> getAllCampaigns(String token) async {
    try {
      final response = await _dio.get(
        "http://192.168.207.158:8000/api/getAllVoluntingCampigns",
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
      "http://192.168.207.158:8000/api/getVoluntingCampigndetails/$id",
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
  final response = await _dio.get(
    "http://192.168.207.158:8000/api/getTaskDetails/$taskId",
    options: Options(
      headers: {"Authorization": "Bearer $token"},
    ),
  );
  print('Full Response: ${response.data}');


  if (response.statusCode == 200 && response.data['status'] == 1) {
    final taskJson = Map<String, dynamic>.from(response.data['data']); // حوّلناها Map<String,dynamic>
 print('Task JSON: $taskJson');
 final task = Task.fromJson(taskJson);


  return task;

  
    } else {
    throw Exception("فشل في جلب تفاصيل التاسك");
  }
}
 Future<List<ScheduledTask>> getScheduledTasks(String token) async {
    final response = await _dio.get(
      "http://192.168.207.158:8000/api/upComingTasks", // عدل الرابط حسب API
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    if (response.statusCode == 200 && response.data['status'] == 1) {
      List<dynamic> data = response.data['data'];
      return data.map((taskJson) => ScheduledTask.fromJson(taskJson)).toList();
    } else {
      throw Exception("فشل في جلب المهام المجدولة");
    }
  }
}
