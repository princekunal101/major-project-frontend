import 'package:college_project/features/auth/data/models/user_id_model.dart';
import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SetPassword {
  final AuthRepositories repositories;

  SetPassword(this.repositories);

  Future<UserIdModel> call(String email, String createPassword) {
    return repositories.setPassword(email, createPassword);
  }
}
