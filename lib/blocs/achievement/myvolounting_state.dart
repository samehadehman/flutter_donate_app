import 'package:hello/models/myvolounting.dart';

abstract class VolunteerState {}

class VolunteerLoading extends VolunteerState {}

class VolunteerLoaded extends VolunteerState {
  final List<Volunteer> volunteers;
  VolunteerLoaded(this.volunteers);
}

class VolunteerError extends VolunteerState {
  final String message;
  VolunteerError(this.message);
}
