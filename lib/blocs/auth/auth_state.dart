// part of 'auth_bloc.dart';

// @immutable
// sealed class AuthState {}

// final class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthSuccess extends AuthState {
//   final String message;

//   AuthSuccess(this.message);
// }

// class AuthFailure extends AuthState {
//   final String error;

//   AuthFailure(this.error);
// }

part of 'auth_bloc.dart';



@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess(this.message);
}

final class AuthFailure extends AuthState {
  final String error;
  

  const AuthFailure(this.error);
}