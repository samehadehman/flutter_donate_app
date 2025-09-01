import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/profile/mini_event.dart';
import 'package:hello/blocs/profile/mini_state.dart';
import 'package:hello/services/userProfile_service.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService service;

  UserBloc({required this.service}) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await service.fetchUserProfile();
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}