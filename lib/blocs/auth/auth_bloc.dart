// blocs/auth/auth_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:hello/models/usermodel.dart';
import 'package:hello/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final isLogged = await authService.login(
          userModel: UserModel(email: event.email, password: event.password),
        );
        if (isLogged) {
                    // ✅ حفظ الإيميل بعد إنشاء الحساب بنجاح

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_email', event.email.trim());
          emit(AuthSuccess());
        } else {
          emit(AuthFailure(message: "خطأ في البريد أو كلمة المرور"));
        }
      } catch (e) {
        emit(AuthFailure(message: "حدث خطأ أثناء تسجيل الدخول"));
      }
    });
    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final isSignedUp = await authService.signup(
          userModel: UserModel(
            name: event.name,
            phone: event.phone,
            email: event.email,
            password: event.password,
          ),
        );
        if (isSignedUp) {
                    //  حفظ الإيميل بعد إنشاء الحساب بنجاح

            final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_email', event.email.trim());

          emit(AuthSuccess());
        } else {
          emit(AuthFailure(message: "خطأ في إنشاء الحساب"));
        }
      } catch (e) {
        emit(AuthFailure(message: "حدث خطأ أثناء إنشاء الحساب"));
      }
    });
  }
}
