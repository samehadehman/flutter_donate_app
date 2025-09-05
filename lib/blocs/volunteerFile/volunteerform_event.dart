import 'package:hello/models/createvolunteerpro_model.dart';


// abstract class VolunteerProfileEvent {}

// class CreateVolunteerProfileEvent extends VolunteerProfileEvent {
//   final VolunteerProfileModel model;
//   CreateVolunteerProfileEvent(this.model);
// }

// class GetVolunteerProfileEvent extends VolunteerProfileEvent {}

// class LoadUserNameEvent extends VolunteerProfileEvent {}


//  abstract class VolunteerProfileUpdateEvent {}

// class UpdateVolunteerProfileEvent extends VolunteerProfileEvent {
//   final VolunteerProfileModel model;
//   UpdateVolunteerProfileEvent(this.model);
// }


abstract class VolunteerProfileEvent {}

class CreateVolunteerProfileEvent extends VolunteerProfileEvent {
  final VolunteerProfileModel model;
  CreateVolunteerProfileEvent(this.model);
}

class UpdateVolunteerProfileEvent extends VolunteerProfileEvent {
  final VolunteerProfileModel model;
  UpdateVolunteerProfileEvent(this.model);
}

class GetVolunteerProfileEvent extends VolunteerProfileEvent {}

class GetVolunteerDetailProfileEvent extends VolunteerProfileEvent {}