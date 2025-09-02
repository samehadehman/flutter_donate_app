import 'package:equatable/equatable.dart';

abstract class VolunteerProfileDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVolunteerDetailProfile extends VolunteerProfileDetailEvent {}

class UpdateVolunteerDetailProfile extends VolunteerProfileDetailEvent {
  final Map<String, dynamic> updatedData;
  UpdateVolunteerDetailProfile(this.updatedData);
}