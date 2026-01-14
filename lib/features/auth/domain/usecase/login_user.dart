import 'package:college_project/features/auth/domain/entities/user.dart';
import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class LoginUser {
  final AuthRepositories repositories;

  LoginUser(this.repositories);

  Future<User> call(String email, String password) {
    return repositories.login(email, password);
  }
}
