import 'dart:convert';

class UserModel {
  final String email;
  final String password;
  final String? name;
  final String? phone;
  UserModel({
    required this.email,
    required this.password,
     this.name,
     this.phone,
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }


 Map<String, dynamic> toMap() {
  final map = <String, dynamic>{
    'email': email,
    'password': password,
  };

  if (name != null) {
    map['name'] = name;
  }
  if (phone != null) {
    map['phone'] = phone;
  }
  return map;
}


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(name: $name, phone: $phone, username: $email, password: $password)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode =>
      name.hashCode ^ phone.hashCode ^ email.hashCode ^ password.hashCode;
}
