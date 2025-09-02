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

  VolunteerProfileBloc(this.service, this.userService)
      : super(VolunteerProfileInitial()) {
    on<CreateVolunteerProfileEvent>(_onCreateProfile);
    on<GetVolunteerProfileEvent>(_onGetProfile);
    on<LoadUserNameEvent>(_onLoadUserName);
  }


  Future<void> _onLoadUserName(
      LoadUserNameEvent event, Emitter<VolunteerProfileState> emit) async {
    emit(VolunteerProfileLoading());
    try {
      final user = await userService.fetchUserProfile();
      emit(VolunteerProfileLoaded(
          VolunteerProfileModel.fromJson({}), // 🔹 dummy فاضي
          userName: user.name));
    } catch (e) {
      emit(VolunteerProfileError(e.toString()));
    }
  }

  Future<void> _onCreateProfile(
      CreateVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
    emit(VolunteerProfileLoading());
    try {
      print("📤 Sending profile JSON: ${jsonEncode(event.model.toJson())}");

      final res = await service.createProfile(event.model.toJson());

      // هون res.data من نوع VolunteerProfileModel
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'volunteer_profile_create', jsonEncode(res.data.toJson()));

      emit(VolunteerProfileSuccess(res.data)); // ✅ بيرجع VolunteerProfileModel
    } catch (e , stackTrace) {
       print("🚨 VolunteerProfileBloc Create Error: $e");
    print(stackTrace);
      emit(VolunteerProfileError(e.toString()));
    }
  }

  Future<void> _onGetProfile(
      GetVolunteerProfileEvent event, Emitter<VolunteerProfileState> emit) async {
    emit(VolunteerProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();

      // ✅ أول شي حاول تجيب نسخة محلية من العرض (VolunteerProfileView)
      final cached = prefs.getString('volunteer_profile_view');
      if (cached != null) {
        final data = VolunteerProfileView.fromJson(jsonDecode(cached));
        emit(VolunteerProfileViewSuccess(data));
      }

      // ✅ بعدين جب نسخة محدثة من السيرفر
      final res = await service.getProfile();
      await prefs.setString(
          'volunteer_profile_view', jsonEncode(res.data.toJson()));

      emit(VolunteerProfileViewSuccess(res.data)); // ✅ بيرجع VolunteerProfileView
    } catch (e , stackTrace) {
       print("🚨 VolunteerProfileBloc Geet Error: $e");
    print(stackTrace);
      emit(VolunteerProfileError(e.toString()));
    }
  }
}
