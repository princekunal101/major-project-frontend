import 'package:college_project/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
