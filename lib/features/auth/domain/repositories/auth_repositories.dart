import 'package:college_project/features/auth/data/models/resend_otp_cool_down_model.dart';
import 'package:college_project/features/auth/data/models/user_id_model.dart';

abstract class AuthRepositories {
  Future<void> signupWithEmail(String email);

  Future<void> verifyOtp(String email, String otp);

  Future<ResendOtpCoolDownModel> resendOtp(String email);

  Future<UserIdModel> setPassword(String email, String createPassword);

  Future<void> login(String email, String password);
}
