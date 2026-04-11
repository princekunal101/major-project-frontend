import 'package:college_project/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:college_project/features/posts/domain/repositories/post_repositories.dart';

class PostRepositoriesImpl extends PostRepositories {
  final PostsRemoteDataSource remoteDataSource;

  PostRepositoriesImpl(this.remoteDataSource);

  @override
  Future<PostListResponseModel> searchPosts(
    String? communityId,
    String? userId,
    String? title,
    String? cursor,
    int? limit,
  ) =>
      remoteDataSource.fetchPosts(communityId, userId, title, cursor, limit);

  @override
  Future<void> createNewPost(
    String communityId,
    String title,
    String? subTitle,
    String body,
    String? tags,
    String? summaryTitle,
    String? summary,
    String contentType,
    String? imageUrl,
  ) {
    final data = <String, dynamic>{};
    data['communityId'] = communityId;
    data['content']['title'] = title;
    if (subTitle != null) data['content']['subTitle'] = subTitle;
    data['content']['body'] = body;
    if (tags != null) data['content']['tags'] = tags;
    if (summaryTitle != null) data['content']['summaryTitle'] = summaryTitle;
    if (summary != null) data['content']['summary'] = summary;
    data['contentType'] = contentType;
    data['imageUrl'] = imageUrl;

    return remoteDataSource.createNewPost(data);
  }

  // @override
  // Future<PostListResponseModel> communityPosts(
  //   String communityId,
  //   String? cursor,
  // ) => remoteDataSource.getCommunityPosts(communityId, cursor);
  //
  // @override
  // Future<PostListResponseModel> userPosts(String userId, String? cursor) =>
  //     remoteDataSource.getUserPosts(userId, cursor);
}
