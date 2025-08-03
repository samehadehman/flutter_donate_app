import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

void toggleConfirmPasswordVisibility() {
  emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
}


  void setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }
}

class LoginState {
  final bool obscurePassword;
    final bool obscureConfirmPassword; 

  final bool isLoading;

  LoginState({
    this.obscurePassword = true,
     this.obscureConfirmPassword = true,
    this.isLoading = false,
  });

  LoginState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? isLoading,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
