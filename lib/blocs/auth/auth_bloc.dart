
import 'package:bloc/bloc.dart';
import 'package:hello/services/auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<RegisterRequested>(_onRegister);
    on<LoginRequested>(_onLogin);
        on<LogoutRequested>(_onLogout); // ✅ جديد

  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // تحقق من كلمة السر
    if (event.password.length < 9) {
      emit(AuthFailure("كلمة السر يجب أن تكون على الأقل 9 محارف"));
      return;
    }

    try {
      final message = await authService.register(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        phone: event.phone,
      );
      emit(AuthSuccess(message));
    } catch (e) {
      final msg = _parseError(e.toString());
      emit(AuthFailure(msg));
    }
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final token = await authService.login(
        email: event.email,
        password: event.password,
      );

      // حفظ التوكن بعد تسجيل الدخول
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
     
      emit(AuthSuccess("تم تسجيل الدخول بنجاح"));
     
    } catch (e) {
      final msg = _parseError(e.toString());
      emit(AuthFailure(msg));
    }
  }
Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
      print("🔹 بدأ تسجيل الخروج");

    emit(AuthLoading());

    try {
      // ✅ استدعاء API تبع تسجيل الخروج
      final message = await authService.logout();
      print("🔹 استجابة الخادم عند تسجيل الخروج: $message");

      // ✅ مسح التوكن من التخزين
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      print("🔹 تم إزالة التوكن من SharedPreferences");

      emit(AuthLoggedOut()); // نجاح
    } catch (e) {
            print("🔴 حدث خطأ أثناء تسجيل الخروج: $e");

      final msg = _parseError(e.toString());
      emit(AuthFailure(msg));
    }
  }
  String _parseError(String error) {
    if (error.contains("422") && error.contains("email")) {
      return "هذا الحساب موجود مسبقاً.";
    } else if (error.contains("422")) {
      return "البريد الإلكتروني أو كلمة المرور غير صحيحة.";
    } 

    else{
      return '------------------------------------------------';
    }
    
    
  }


}