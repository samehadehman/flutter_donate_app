import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/userinfo/userinfo_event.dart';
import 'package:hello/blocs/userinfo/userinfo_state.dart';
import 'package:hello/services/userInfo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoService service;
  UserInfoBloc(this.service) : super(UserInfoInitial()) {
    on<FetchUserInfo>((event, emit) async {
      emit(UserInfoLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';
        if (token == null) throw Exception("Token not found");
        final user = await service.getUserInfo(token);
        emit(UserInfoLoaded(user));
      } catch (e) {
        emit(UserInfoError(e.toString()));
      }
    });

    on<UpdateUserInfo>((event, emit) async {
      emit(UserInfoUpdating());
      try {
        final updatedUser = await service.updateProfile(
          name: event.name,
          phone: event.phone,
          age: event.age,
          gender: event.gender,
          city: event.city,
        );

        emit(UserInfoUpdated(updatedUser, "تم التحديث بنجاح"));
      } catch (e) {
        emit(UserInfoError(e.toString()));
      }
    });
  }
}
