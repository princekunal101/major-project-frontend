import 'package:college_project/features/community/data/models/community_result_model.dart';
import 'package:college_project/features/community/domain/repositories/community_repositories.dart';

class GetCommunity {
  final CommunityRepositories repositories;

  GetCommunity(this.repositories);

  Future<CommunityResultModel> call(String communityId) =>
      repositories.getCommunityResult(communityId);
}
