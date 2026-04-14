import 'package:college_project/core/utils/enums/post_reaction_type.dart';
import 'package:college_project/features/posts/data/models/post_liked_user_response_model.dart';
import 'package:college_project/features/posts/data/models/post_list_response_model.dart';

abstract class PostRepositories {
  Future<PostListResponseModel> searchPosts(
    String? communityId,
    String? userId,
    String? title,
    String? cursor,
    int? limit,
  );

  Future<void> createNewPost(
    String communityId,
    String title,
    String? subTitle,
    String body,
    String? tags, //array
    String? summaryTitle,
    String? summary,
    String contentType,
    String? imageUrl,
  );

  Future<void> postReaction(String postId, String reactType);

  Future<void> deletePostReaction(String postId);

  Future<void> fetchPostLikedCount(String postId);

  Future<PostLikedUserResponseModel> fetchPostLikedUser(
    String postId,
    String? cursor,
  );
}
