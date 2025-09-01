// abstract class ForgotPasswordState {}

// class ForgotPasswordInitial extends ForgotPasswordState {}

// class ForgotPasswordLoading extends ForgotPasswordState {}

// class ForgotPasswordSuccess extends ForgotPasswordState {
//   final String email;
//   ForgotPasswordSuccess(this.email,);
// }

// class ForgotPasswordFailure extends ForgotPasswordState {
//   final String message;
//   ForgotPasswordFailure(this.message);
// }

// class CodeVerificationSuccess extends ForgotPasswordState {
//   final String code;
//   final String email;

//   CodeVerificationSuccess(this.code, this.email);
// }


// abstract class ResetPasswordState {}

// class ResetPasswordInitial extends ResetPasswordState {}

// class ResetPasswordLoading extends ResetPasswordState {}

// class ResetPasswordSuccess extends ResetPasswordState {
//   final String token;
//   final int role;

//   ResetPasswordSuccess({required this.token, required this.role});
// }

// class ResetPasswordFailure extends ResetPasswordState {
//   final String message;

//   ResetPasswordFailure({required this.message});
// }

import 'package:equatable/equatable.dart';

import 'package:hello/models/forgetpass_model.dart';
import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;

  const ForgotPasswordSuccess(this.email);

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}


abstract class VerifyCodeState extends Equatable {
  const VerifyCodeState();

  @override
  List<Object?> get props => [];
}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final String token;
  final String code;

  const VerifyCodeSuccess({required this.token, required this.code});

  @override
  List<Object?> get props => [token, code];
}

class VerifyCodeFailure extends VerifyCodeState {
  final String error;

  const VerifyCodeFailure(this.error);

  @override
  List<Object?> get props => [error];
}


abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String token;
  final int role;

  const ResetPasswordSuccess({required this.token, required this.role});

  @override
  List<Object?> get props => [token, role];
}

class ResetPasswordFailure extends ResetPasswordState {
  final String error;

  const ResetPasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

