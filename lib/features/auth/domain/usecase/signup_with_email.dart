import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SignupWithEmail {
  final AuthRepositories repo;

  SignupWithEmail(this.repo);

  Future<void> call(String email) => repo.signupWithEmail(email);
}
