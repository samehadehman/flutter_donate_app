// import 'package:equatable/equatable.dart';
// import 'package:hello/models/createvolunteerpro_model.dart';

// abstract class VolunteerProfileDetailState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class VolunteerProfileDetailInitial extends VolunteerProfileDetailState {}

// class VolunteerProfileDetailLoading extends VolunteerProfileDetailState {}
// class VolunteerProfileDetailSuccess extends VolunteerProfileDetailState {}

// class VolunteerProfileDetailLoaded extends VolunteerProfileDetailState {
//   final VolunteerProfileModel profile;

//   VolunteerProfileDetailLoaded(this.profile);

//   @override
//   List<Object?> get props => [profile];
// }

// class VolunteerProfileDetailError extends VolunteerProfileDetailState {
//   final String message;

//   VolunteerProfileDetailError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class VolunteerProfileUpdateLoading extends VolunteerProfileDetailState {}

// class VolunteerProfileUpdateSuccess extends VolunteerProfileDetailState {
//   final String message;
//   VolunteerProfileUpdateSuccess(this.message);
// }

// class VolunteerProfileUpdateError extends VolunteerProfileDetailState {
//   final String message;
//   VolunteerProfileUpdateError(this.message);
// }