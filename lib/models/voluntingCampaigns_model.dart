class CampaignModel {
  final int id;
  final String title;
  final String photo;
  final int numberOfTasks;
  final String classificationName;
  final String statusType;

  CampaignModel({
    required this.id,
    required this.title,
    required this.photo,
    required this.numberOfTasks,
    required this.classificationName,
    required this.statusType,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    String rawPhoto = '';
    final dynamic p = json['photo'];
    if (p is String) {
      rawPhoto = p;
    } else if (p is Map<String, dynamic>) {
      rawPhoto = p['photo']?.toString() ?? '';
    }

    if (rawPhoto.startsWith('http://localhost')) {
      rawPhoto = rawPhoto.replaceFirst(
          'http://localhost', 'http://192.168.207.158'); 
    }

    return CampaignModel(
      id: json['id'],
      title: json['title'],
      photo: rawPhoto, 
      numberOfTasks: json['number_of_tasks'],
      classificationName: json['classification_id']['classification_name'],
      statusType: json['campaign_status_id']['campaign_status_type'],
    );
  }
}
