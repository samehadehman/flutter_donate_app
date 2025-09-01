import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_state.dart';
import 'package:hello/services/userProfile_service.dart';
import 'package:hello/services/volunteerProfileForm_service.dart';


class VolunteerProfileBloc extends Bloc<VolunteerProfileEvent, VolunteerProfileState> {
  final VolunteerService service;
  final UserService userService;

  VolunteerProfileBloc(this.service, this.userService) : super(VolunteerProfileInitial()) {
    on<CreateVolunteerProfileEvent>(_onCreateProfile);
    on<GetVolunteerProfileEvent>(_onGetProfile);
    on<LoadUserNameEvent>(_onLoadUserName);
  }

  Future<void> _onLoadUserName(
      LoadUserNameEvent event, Emitter<VolunteerProfileState> emit) async {
    emit(VolunteerProfileLoading());
    try {
      final user = await userService.fetchUserProfile();
      emit(VolunteerProfileLoaded(userName: user.name));
    } catch (e) {
      emit(VolunteerProfileError(e.toString()));
    }
  }

  Future<void> _onCreateProfile(
      CreateVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
    emit(VolunteerProfileLoading());
    try {
    final res = await service.createProfile(event.model.toJson());
      emit(VolunteerProfileSuccess(res.data)); // ✅ رجع الـ VolunteerProfileModel
    } catch (e) {
      emit(VolunteerProfileError(e.toString()));
    }
  }

  Future<void> _onGetProfile(
      GetVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
    emit(VolunteerProfileLoading());
    try {
      final res = await service.getProfile();
      emit(VolunteerProfileViewSuccess(res.data)); // ✅ رجع الـ VolunteerProfileView
    } catch (e) {
      emit(VolunteerProfileError(e.toString()));
    }
  }
}
