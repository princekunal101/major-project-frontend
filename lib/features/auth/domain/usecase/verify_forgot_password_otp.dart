import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class VerifyForgotPasswordOtp {
  final AuthRepositories repositories;

  VerifyForgotPasswordOtp(this.repositories);

  Future<void> call(String email, String otp) =>
      repositories.verifyForgotPasswordOtp(email, otp);
}
