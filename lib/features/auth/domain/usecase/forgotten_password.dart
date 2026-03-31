import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class ForgottenPassword {
  final AuthRepositories repositories;

  ForgottenPassword(this.repositories);

  Future<void> call(String email, bool isOtpMode) =>
      repositories.forgottenPassword(email, isOtpMode);
}
