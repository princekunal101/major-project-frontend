import 'package:college_project/features/auth/data/models/username_suggestion_model.dart';

enum CreateSetUsernameType { success, conflict }

class CreateUsernameSuggestion {
  final CreateSetUsernameType type;
  final UsernameSuggestionModel? suggestionModel;

  CreateUsernameSuggestion.success()
    : type = CreateSetUsernameType.success,
      suggestionModel = null;

  CreateUsernameSuggestion.conflict(this.suggestionModel)
    : type = CreateSetUsernameType.conflict;
}
