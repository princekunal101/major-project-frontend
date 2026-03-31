import 'package:college_project/features/auth/data/models/username_suggestion_model.dart';

abstract class SetUsernameState {}

class SetUsernameInitials extends SetUsernameState {}

class SetUsernameLoading extends SetUsernameState {}

class SetUsernameSuccess extends SetUsernameState {}

class SetUsernameConflict extends SetUsernameState {
  final UsernameSuggestionModel suggestionModel;

  SetUsernameConflict(this.suggestionModel);
}

class SetUsernameFailure extends SetUsernameState {
  final String message;

  SetUsernameFailure(this.message);
}
