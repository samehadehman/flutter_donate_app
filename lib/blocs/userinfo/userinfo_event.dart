import 'dart:io';

abstract class UserInfoEvent {

}
class FetchUserInfo extends UserInfoEvent {

}
class UpdateUserInfo extends UserInfoEvent {
  final String name;
  final String phone;
  final String? age; // nullable
  final int? gender; // nullable لأن ممكن ما يختار
  final int? city;   // nullable لأن ممكن ما يختار

  UpdateUserInfo({
    required this.name,
    required this.phone,
    this.age,
    this.gender,
    this.city, 
  });
}
