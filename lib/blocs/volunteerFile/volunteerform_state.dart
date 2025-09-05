import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';


// abstract class VolunteerProfileState {}

// class VolunteerProfileInitial extends VolunteerProfileState {}

// class VolunteerProfileLoading extends VolunteerProfileState {}

// class VolunteerProfileSuccess extends VolunteerProfileState {
//   final VolunteerProfileModel profile; // بيرجع من create
//   VolunteerProfileSuccess(this.profile);
// }

// class VolunteerProfileViewSuccess extends VolunteerProfileState {
//   final VolunteerProfileView profile; // بيرجع من get
//   VolunteerProfileViewSuccess(this.profile);
// }

// class VolunteerProfileLoaded extends VolunteerProfileState {
//   final String userName;
//   VolunteerProfileLoaded(VolunteerProfileModel data, {required this.userName});
// }

// class VolunteerProfileError extends VolunteerProfileState {
//   final String message;
//   VolunteerProfileError(this.message);
// }

// //update
// abstract class VolunteerProfileUpdateState {}

// class VolunteerProfileUpdateInitial extends VolunteerProfileUpdateState {}

// class VolunteerProfileUpdateLoading extends VolunteerProfileUpdateState {}

// class VolunteerProfileUpdateSuccess extends VolunteerProfileUpdateState {}

// class VolunteerProfileUpdateError extends VolunteerProfileUpdateState {
//   final String message;
//   VolunteerProfileUpdateError(this.message);
// }



abstract class VolunteerProfileState {}

class VolunteerProfileInitial extends VolunteerProfileState {}

class VolunteerProfileLoading extends VolunteerProfileState {}

/// نجاح إنشاء/تعديل
class VolunteerProfileSuccess extends VolunteerProfileState {
  final VolunteerProfileModel profile;
  VolunteerProfileSuccess(this.profile);
}

/// نجاح جلب الملف (عرض)
class VolunteerProfileViewSuccess extends VolunteerProfileState {
  final VolunteerProfileView profile;
  VolunteerProfileViewSuccess(this.profile);
}

class VolunteerProfileError extends VolunteerProfileState {
  final String message;
  VolunteerProfileError(this.message);
}

class VolunteerProfileDetailsLoaded extends VolunteerProfileState {
  final VolunteerProfileModel profile;
  VolunteerProfileDetailsLoaded(this.profile);
}