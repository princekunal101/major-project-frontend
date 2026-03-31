import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SetFullName {
  final AuthRepositories repositories;

  SetFullName(this.repositories);

  Future<void> call(String userId, String fullName) {
    return repositories.setFullName(userId, fullName);
  }
}
