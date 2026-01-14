import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class VerifyOtp {
  final AuthRepositories repo;

  VerifyOtp(this.repo);

  Future<void> call(String email, String otp) => repo.verifyOtp(email, otp);
}
