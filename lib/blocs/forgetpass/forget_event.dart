// abstract class ForgotPasswordEvent {}

// class SubmitEmailEvent extends ForgotPasswordEvent {
//   final String email;
//   SubmitEmailEvent(this.email);
// }

// class SubmitCodeEvent extends ForgotPasswordEvent {
//   final String code;
//   final String email;

//   SubmitCodeEvent(this.email, this.code);
// }

// abstract class ResetPasswordEvent {}

// class ResetPasswordSubmitted extends ResetPasswordEvent {
//   final String code;
//   final String newpassword;
//   final String email;

// ResetPasswordSubmitted({
//     required this.email,
//     required this.code,
//     required this.newpassword,
//   });

//   @override
//   List<Object?> get props => [email, code, newpassword];
// }
import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SubmitEmailEvent extends ForgotPasswordEvent {
  final String email;

  const SubmitEmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}


abstract class VerifyCodeEvent extends Equatable {
  const VerifyCodeEvent();

  @override
  List<Object?> get props => [];
}

class SubmitCodeEvent extends VerifyCodeEvent {
  final String email;
  final String code;

  const SubmitCodeEvent({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}


abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String email;
  final String code;
  final String newpassword;

  const ResetPasswordSubmitted({
    required this.email,
    required this.code,
    required this.newpassword,
  });

  @override
  List<Object?> get props => [email, code, newpassword];
}
