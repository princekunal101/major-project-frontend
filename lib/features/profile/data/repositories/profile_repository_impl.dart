import 'package:college_project/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:college_project/features/profile/data/models/is_username_available_model.dart';
import 'package:college_project/features/profile/data/models/profile_result_model.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';

class ProfileRepositoryImpl extends ProfileRepositories {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<ProfileResultModel> getUserProfile() => remote.fetchProfile();

  @override
  Future<void> updateProfile(
    String? fullName,
    String? username,
    String? gender,
    String? bio,
    String? pronoun,
    String? dob,
    String? link,
  ) {
    final data = <String, dynamic>{};
    if (fullName != null) data['fullName'] = fullName;
    if (username != null) data['username'] = username;
    if (gender != null) data['gender'] = gender;
    if (bio != null) data['bio'] = bio;
    if (pronoun != null) data['pronouns'] = pronoun;
    if (dob != null) data['dob'] = dob;
    if (link != null) data['link'] = link;
    return remote.updateProfile(data);
  }

  @override
  Future<IsUsernameAvailableModel> checkIsUsernameAvailable(String username) =>
      remote.checkIsAvailableUsername(username);

  @override
  Future<void> changePassword(String oldPassword, String newPassword) =>
      remote.changePassword(oldPassword, newPassword);
}
