class CampaignDetailsModel {
  final int id;
  final String title;
  final String description;
  final String location;
  final String photo;
  final String classificationName;
  final String statusType;
  final int numberOfTasks;
  final String startDate;
  final String endDate;
  final String tasksTime;
  final List<Task> tasks;

  CampaignDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.photo,
    required this.classificationName,
    required this.statusType,
    required this.numberOfTasks,
    required this.startDate,
    required this.endDate,
    required this.tasksTime,
    required this.tasks,
  });

  factory CampaignDetailsModel.fromJson(Map<String, dynamic> json) {
    String rawPhoto = json['photo'] ?? '';
    if (rawPhoto.startsWith('http://localhost')) {
      rawPhoto = rawPhoto.replaceFirst(
        'http://localhost',
        'http://192.168.207.158', // ضع IP جهاز السيرفر
      );
    }

    return CampaignDetailsModel(
     id: json['id'] ?? 0,
      title: json['title']?.toString() ?? 'بدون عنوان',
      description: json['description']?.toString() ?? 'لا يوجد وصف',
      photo: rawPhoto,
      startDate: json['campaign_start_time'] ?? '',
      endDate: json['campaign_end_time'] ?? '',
      tasksTime: json['tasks_time'] ?? '',
      statusType: json['campaign_status_id']?['campaign_status_type']?.toString() ?? '',
      classificationName: json['classification_id']?['classification_name']?.toString() ?? '',
      location: json['location']?.toString() ?? 'غير محدد',
      tasks: (json['tasks'] as List? ?? [])
          .map((t) => Task.fromJson(t))
          .toList(),
      numberOfTasks: json['number_of_tasks'] ?? 0,
    );
  }

}

class Task {
    final int id; // جديد

  final String taskName;
  final String description;
  final int hours;
  final int numberVolunterNeed;
  

Task({
      required this.id,

    required this.taskName,
    required this.description,
    required this.hours,
    required this.numberVolunterNeed,
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
            id: json['id'] ?? 0,

      taskName: json['task_name']?.toString() ?? 'بدون اسم',
      description: json['description']?.toString() ?? 'لا يوجد وصف',
      hours: json['hours'] ?? 0,
      numberVolunterNeed: json['number_volunter_need'] ?? 0,
    );
  }
}
