import 'package:college_project/features/community/data/models/is_community_name_available_model.dart';
import 'package:college_project/features/community/domain/repositories/community_repositories.dart';

class CheckCommunityNameAvailability {
  final CommunityRepositories repositories;

  CheckCommunityNameAvailability(this.repositories);

  Future<IsCommunityNameAvailableModel> call(String communityName) =>
      repositories.checkIsCommunityNameAvailable(communityName);

}
