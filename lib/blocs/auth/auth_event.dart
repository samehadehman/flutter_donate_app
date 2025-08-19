// part of 'auth_bloc.dart';

// @immutable
// sealed class AuthEvent {}
// // blocs/auth/auth_event.dart

// class RegisterRequested extends AuthEvent {
//   final String name;
//   final String email;
//   final String password;
//   final String confirmPassword;
//   final String phone;

//   RegisterRequested({
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.confirmPassword,
//     required this.phone,
//   });
// }

// class LoginRequested extends AuthEvent {
//   final String email;
//   final String password;

//   LoginRequested({
//     required this.email,
//     required this.password,
//   });
// }


part of 'auth_bloc.dart';

sealed class AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;

  RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
  });
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({
    required this.email,
    required this.password,
  });
}