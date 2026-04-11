import 'package:college_project/features/feed/data/models/community_list_response_model.dart';
import 'package:college_project/features/feed/data/models/feed_list_response_model.dart';

abstract class FeedRepositories {
  Future<CommunityListResponseModel> searchCommunity(
    String? communityName,
    String? displayName,
  );

  Future<FeedListResponseModel> getAllPosts(String? cursor, int? limit);

  Future<FeedListResponseModel> getFeeds(String? cursor, int? limit);
}
