import 'package:hello/models/createvolunteerpro_model.dart';


abstract class VolunteerProfileEvent {}

class CreateVolunteerProfileEvent extends VolunteerProfileEvent {
  final VolunteerProfileModel model;
  CreateVolunteerProfileEvent(this.model);
}

class GetVolunteerProfileEvent extends VolunteerProfileEvent {}

class LoadUserNameEvent extends VolunteerProfileEvent {}


