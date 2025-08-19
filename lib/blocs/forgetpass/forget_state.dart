abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;
  ForgotPasswordSuccess(this.email,);
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;
  ForgotPasswordFailure(this.message);
}

class CodeVerificationSuccess extends ForgotPasswordState {
  final String code;

  CodeVerificationSuccess(this.code);
}


abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String token;
  final int role;

  ResetPasswordSuccess({required this.token, required this.role});
}

class ResetPasswordFailure extends ResetPasswordState {
  final String message;

  ResetPasswordFailure({required this.message});
}
