import 'package:college_project/features/auth/domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel({
    required super.accessToken,
    required super.refreshToken,
    required super.userId,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {

    return AuthResultModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      userId: json['userId'],
    );
  }
}
