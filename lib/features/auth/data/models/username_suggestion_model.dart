import 'package:college_project/features/auth/domain/entities/username_suggestion.dart';

class UsernameSuggestionModel extends UsernameSuggestion {
  UsernameSuggestionModel({required super.message, required super.usernames});

  factory UsernameSuggestionModel.fromJson(Map<String, dynamic> json) {
    return UsernameSuggestionModel(
      message: json['message'],
      usernames: List.from(json['usernames']),
    );
  }
}
