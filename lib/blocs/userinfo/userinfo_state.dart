import 'package:hello/models/userInfo.dart';

abstract class UserInfoState {}
class UserInfoInitial extends UserInfoState {}
class UserInfoLoading extends UserInfoState {}
class UserInfoLoaded extends UserInfoState {
  final UserInfo userInfo;
  UserInfoLoaded(this.userInfo);
}

class UserInfoUpdating extends UserInfoState {}
class UserInfoUpdated extends UserInfoState {
    final UserInfo user;
  final String message;
  UserInfoUpdated(this.user,this.message);
}

class UserInfoError extends UserInfoState {
  final String message;
  UserInfoError(this.message);
}