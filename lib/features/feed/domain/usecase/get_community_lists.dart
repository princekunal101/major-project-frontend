import 'package:college_project/features/feed/data/models/community_list_response_model.dart';
import 'package:college_project/features/feed/domain/repositories/feed_repositories.dart';

class GetCommunityLists {
  final FeedRepositories repositories;

  GetCommunityLists(this.repositories);

  Future<CommunityListResponseModel> call(
    String? communityName,
    String? displayName,
  ) => repositories.searchCommunity(communityName, displayName);
}
