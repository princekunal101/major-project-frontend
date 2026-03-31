import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SetForgotNewPassword {
  final AuthRepositories repositories;

  SetForgotNewPassword(this.repositories);

  Future<void> call(String email, String newPassword) {
    return repositories.setForgotNewPassword(email, newPassword);
  }
}
