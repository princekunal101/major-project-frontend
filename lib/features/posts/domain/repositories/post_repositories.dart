import 'package:college_project/features/posts/data/models/post_list_response_model.dart';

abstract class PostRepositories {
  Future<PostListResponseModel> searchPosts(
    String communityId,
    String? title,
    String? cursor,
  );
}
