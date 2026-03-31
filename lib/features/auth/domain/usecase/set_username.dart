import 'package:college_project/core/models/create_username_suggestion.dart';
import 'package:college_project/features/auth/data/models/username_suggestion_model.dart';
import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SetUsername {
  final AuthRepositories repositories;

  SetUsername(this.repositories);

  Future<CreateUsernameSuggestion> call(String userId, String username) =>
      repositories.setUsername(userId, username);
}
