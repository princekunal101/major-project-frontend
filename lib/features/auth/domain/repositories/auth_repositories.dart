import 'package:college_project/features/auth/data/models/resend_otp_cool_down_model.dart';


abstract class AuthRepositories {
  Future<void> signupWithEmail(String email);

  Future<void> verifyOtp(String email, String otp);

  Future<ResendOtpCoolDownModel> resendOtp(String email);

  Future<void> login(String email, String password);
}
