import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:college_project/features/posts/domain/entities/search_posts_params.dart';
import 'package:college_project/features/posts/domain/repositories/post_repositories.dart';

class SearchPosts {
  final PostRepositories repositories;

  SearchPosts(this.repositories);

  Future<PostListResponseModel> call(SearchPostsParams params) =>
      repositories.searchPosts(
        params.communityId,
        params.userId,
        params.title,
        params.cursor,
        params.limit,
      );
}
