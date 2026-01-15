import 'package:college_project/features/auth/domain/entities/user.dart';

abstract class AuthRepositories {
  Future<void> sendOtp(String email);
  Future<void> verifyOtp(String email, String otp);
  Future<void> login(String email, String password);
}