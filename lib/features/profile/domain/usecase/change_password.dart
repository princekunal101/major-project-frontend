import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';

class ChangePassword {
  final ProfileRepositories repositories;

  ChangePassword(this.repositories);

  Future<void> call(String oldPassword, String newPassword) =>
      repositories.changePassword(oldPassword, newPassword);
}
