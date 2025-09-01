class ForgotPasswordModel {
  final int status;
  final String message;
  final ForgotPasswordData? data;

  ForgotPasswordModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? ForgotPasswordData.fromJson(json['data']) : null,
    );
  }
}

class ForgotPasswordData {
  final String email;
  final int code;
  final int role;

  ForgotPasswordData({
    required this.email,
    required this.code,
    required this.role,
  });

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordData(
      email: json['email'] ?? '',
      code: json['code'] ?? 0,
      role: json['role'] ?? 0,
    );
  }
}
class VerifyCodeModel {
  final int status;
  final String message;
  final VerifyCodeData? data;

  VerifyCodeModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) {
    return VerifyCodeModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? VerifyCodeData.fromJson(json['data']) : null,
    );
  }
}

class VerifyCodeData {
  final String token;
  final String code;

  VerifyCodeData({
    required this.token,
    required this.code,
  });

  factory VerifyCodeData.fromJson(Map<String, dynamic> json) {
    return VerifyCodeData(
      token: json['token'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
class ResetPasswordResponse {
  final int status;
  final String message;
  final ResetPasswordData? data;

  ResetPasswordResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? ResetPasswordData.fromJson(json['data']) : null,
    );
  }
}

class ResetPasswordData {
  final String token;
  final int role;

  ResetPasswordData({
    required this.token,
    required this.role,
  });

  factory ResetPasswordData.fromJson(Map<String, dynamic> json) {
    return ResetPasswordData(
      token: json['token'] ?? '',
      role: json['role'] ?? 0,
    );
  }
}
