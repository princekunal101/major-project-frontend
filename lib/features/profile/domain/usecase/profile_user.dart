import 'package:college_project/features/profile/data/models/profile_result_model.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';

class ProfileUser {
  final ProfileRepositories repositories;

  ProfileUser(this.repositories);

  Future<ProfileResultModel> call() => repositories.getUserProfile();
}
