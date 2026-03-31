import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';

class UpdateProfile {
  final ProfileRepositories repositories;

  UpdateProfile(this.repositories);

  Future<void> call(
    String? fullName,
    String? username,
    String? gender,
    String? bio,
    String? pronoun,
    String? dob,
    String? link,
  ) => repositories.updateProfile(
    fullName,
    username,
    gender,
    bio,
    pronoun,
    dob,
    link,
  );
}
