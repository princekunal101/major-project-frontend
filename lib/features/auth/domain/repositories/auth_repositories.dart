import 'package:college_project/core/models/create_username_suggestion.dart';
import 'package:college_project/features/auth/data/models/resend_otp_cool_down_model.dart';
import 'package:college_project/features/auth/data/models/user_id_model.dart';

abstract class AuthRepositories {
  Future<void> signupWithEmail(String email);

  Future<void> verifyOtp(String email, String otp);

  Future<ResendOtpCoolDownModel> resendOtp(String email);

  Future<UserIdModel> setPassword(String email, String createPassword);

  Future<void> login(String email, String password);

  Future<void> setDob(String userId, String dob);

  Future<void> setFullName(String userId, String fullName);

  Future<CreateUsernameSuggestion> setUsername(String userId, String username);

  Future<void> acceptedTerms(String userId, bool acceptedTerms);

  Future<void> forgottenPassword(String email, bool isOtpMode);

  Future<void> verifyForgotPasswordOtp(String email, String otp);

  Future<void> setForgotNewPassword(String email, String newPassword);

}
