import 'package:college_project/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:college_project/features/feed/data/models/community_list_response_model.dart';
import 'package:college_project/features/feed/data/models/feed_list_response_model.dart';
import 'package:college_project/features/feed/domain/repositories/feed_repositories.dart';

class FeedRepositoryImpl extends FeedRepositories {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl(this.remoteDataSource);

  @override
  Future<CommunityListResponseModel> searchCommunity(
    String? communityName,
    String? displayName,
  ) => remoteDataSource.searchCommunity(communityName, displayName);

  @override
  Future<FeedListResponseModel> getAllPosts(String? cursor, int? limit) =>
      remoteDataSource.getAllPosts(cursor, limit);

  @override
  Future<FeedListResponseModel> getFeeds(String? cursor, int? limit) =>
      remoteDataSource.getFeeds(cursor, limit);
}
