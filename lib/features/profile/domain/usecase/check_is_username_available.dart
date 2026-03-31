import 'package:college_project/features/profile/data/models/is_username_available_model.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';

class CheckIsUsernameAvailable {
  final ProfileRepositories repositories;

  CheckIsUsernameAvailable(this.repositories);

  Future<IsUsernameAvailableModel> call(String username) =>
      repositories.checkIsUsernameAvailable(username);
}
