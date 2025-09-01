import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_event.dart';
import 'package:hello/blocs/volunteerFile/volunteerform_state.dart';
import 'package:hello/models/createvolunteerpro_model.dart';
import 'package:hello/models/showVolunteerpro_model.dart';
import 'package:hello/services/userProfile_service.dart';
import 'package:hello/services/volunteerProfileForm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('volunteer_profile', jsonEncode(res.data.toJson()));
      emit(VolunteerProfileSuccess(res.data)); // ✅ رجع الـ VolunteerProfileModel
    } catch (e) {
      emit(VolunteerProfileError(e.toString()));
    }
  }


Future<void> _onGetProfile(
    GetVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
  emit(VolunteerProfileLoading());
  try {
    final prefs = await SharedPreferences.getInstance();

    // ✅ أول شي حاول تجيب نسخة محلية
    final cached = prefs.getString('volunteer_profile');
    if (cached != null) {
        final data = VolunteerProfileModel.fromJson(jsonDecode(cached));
      emit(VolunteerProfileViewSuccess(data as VolunteerProfileView));
    }

    // ✅ بعدين جب نسخة محدثة من السيرفر
    final res = await service.getProfile();
    await prefs.setString('volunteer_profile', jsonEncode(res.data.toJson()));

    emit(VolunteerProfileViewSuccess(res.data));
  } catch (e) {
    emit(VolunteerProfileError(e.toString()));
  }
}
}
