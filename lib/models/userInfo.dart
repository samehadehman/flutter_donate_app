class UserInfo {
  final String? userName;
  final String? name;
  final int? cityId;          // رقم المدينة
  final String? cityName;     // اسم المدينة
  final String? phone;
  final String? age;
  final int? genderId;        // رقم الجنس
  final String? gender;       // نوع الجنس
  final String? email;

  UserInfo({
    this.userName,
    this.name,
    this.cityId,
    this.cityName,
    this.phone,
    this.age,
    this.genderId,
    this.gender,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return UserInfo(
      userName: data['user_name'],
      name: data['name'],
      cityId: data['city_id']?['id'],
      cityName: data['city_id']?['city_name'],
    phone: data['phone'],
      age: data['age']?.toString(),
      genderId: data['gender_id']?['id'],
      gender: data['gender_id']?['gender_type'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userName != null) "user_name": userName,
      if (name != null) "name": name,
      if (cityId != null) "city_id": cityId,       
      if (phone != null) "phone": phone,
      if (age != null) "age": age,
      if (genderId != null) "gender_id": genderId, 
      if (email != null) "email": email,
    };
  }
}
