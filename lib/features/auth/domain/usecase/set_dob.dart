import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SetDob {
  final AuthRepositories repositories;

  SetDob(this.repositories);

  Future<void> call(String userId, String dob) {
    return repositories.setDob(userId, dob);
  }
}
