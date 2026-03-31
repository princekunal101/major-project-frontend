import 'package:college_project/features/profile/domain/entities/is_username_available.dart';

class IsUsernameAvailableModel extends IsUsernameAvailable {
  IsUsernameAvailableModel({
    required super.isAvailable,
    required super.username,
  });

  factory IsUsernameAvailableModel.fromJson(Map<String, dynamic> json) {
    return IsUsernameAvailableModel(
      isAvailable: json['isAvailable'],
      username: json['username'],
    );
  }
}
