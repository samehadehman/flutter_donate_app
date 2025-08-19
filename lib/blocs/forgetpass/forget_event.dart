abstract class ForgotPasswordEvent {}

class SubmitEmailEvent extends ForgotPasswordEvent {
  final String email;
  SubmitEmailEvent(this.email);
}

class SubmitCodeEvent extends ForgotPasswordEvent {
  final String code;
  final String email;

  SubmitCodeEvent(this.email, this.code);
}

abstract class ResetPasswordEvent {}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String email;
  final String password;

  ResetPasswordSubmitted({required this.email, required this.password});
}
