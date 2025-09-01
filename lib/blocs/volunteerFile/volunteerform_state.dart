import 'package:equatable/equatable.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';
import 'package:hello/models/volunteerProfileForm_model.dart';


abstract class VolunteerProfileState {}

class VolunteerProfileInitial extends VolunteerProfileState {}

class VolunteerProfileLoading extends VolunteerProfileState {}

class VolunteerProfileSuccess extends VolunteerProfileState {
  final VolunteerProfileModel profile; // بيرجع من create
  VolunteerProfileSuccess(this.profile);
}

class VolunteerProfileViewSuccess extends VolunteerProfileState {
  final VolunteerProfileView profile; // بيرجع من get
  VolunteerProfileViewSuccess(this.profile);
}

class VolunteerProfileLoaded extends VolunteerProfileState {
  final String userName;
  VolunteerProfileLoaded({required this.userName});
}

class VolunteerProfileError extends VolunteerProfileState {
  final String message;
  VolunteerProfileError(this.message);
}
