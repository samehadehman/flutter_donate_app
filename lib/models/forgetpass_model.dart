// lib/core/models/forgot_password_model.dart
class ForgotPasswordModel {
  final int status;
  final Data data;
  final String message;

  ForgotPasswordModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final String email;
  final int code;
  final int role;

  Data({required this.email, required this.code, required this.role});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json['email'],
      code: json['code'],
      role: json['role'],
    );
  }
}

// lib/models/verify_code_model.dart
class VerifyCodeModel {
  final int status;
  final String token;
  final String code;
  final String message;

  VerifyCodeModel({
    required this.status,
    required this.token,
    required this.code,
    required this.message,
  });

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) {
    return VerifyCodeModel(
      status: json['status'],
      token: json['data']['token'],
      code: json['data']['code'].toString(),
      message: json['message'],
    );
  }
}

class ResetPasswordResponse {
  final int status;
  final String token;
  final int role;
  final String message;

  ResetPasswordResponse({
    required this.status,
    required this.token,
    required this.role,
    required this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'],
      token: json['data']['token'],
      role: json['data']['role'],
      message: json['message'],
    );
  }
}



