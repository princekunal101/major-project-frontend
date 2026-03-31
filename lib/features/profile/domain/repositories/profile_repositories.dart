import 'package:college_project/features/profile/data/models/is_username_available_model.dart';
import 'package:college_project/features/profile/data/models/profile_result_model.dart';

abstract class ProfileRepositories {
  Future<ProfileResultModel> getUserProfile();

  Future<void> updateProfile(
    String? fullName,
    String? username,
    String? gender,
    String? bio,
    String? pronoun,
    String? dob,
    String? link,
  );

  Future<IsUsernameAvailableModel> checkIsUsernameAvailable(String username);

  Future<void> changePassword(String oldPassword, String newPassword);
}
