class UserModel {
  final String name;
  final String avatarUrl;
  final int points;

  UserModel({
    required this.name,
    required this.avatarUrl,
    required this.points,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    String rawPhoto = '';
    final dynamic p = json['photo'];
    if (p is String) {
      rawPhoto = p;
    } else if (p is Map<String, dynamic>) {
      rawPhoto = p['photo']?.toString() ?? '';
    }

    if (rawPhoto.startsWith('http://localhost')) {
      rawPhoto = rawPhoto.replaceFirst('http://localhost', 'http://192.168.173.158');
    }


 
    return UserModel(
      name: json['user name'] ?? 'غير محدد',
      avatarUrl: rawPhoto,
      points: json['points'] ?? 0,
    );
  }
}
