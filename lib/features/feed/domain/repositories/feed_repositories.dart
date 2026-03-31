import 'package:college_project/features/feed/data/models/community_list_response_model.dart';

abstract class FeedRepositories {
  Future<CommunityListResponseModel> searchCommunity(
    String? communityName,
    String? displayName,
  );
}
