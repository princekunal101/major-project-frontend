import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:college_project/features/posts/domain/repositories/post_repositories.dart';

class SearchPosts {
  final PostRepositories repositories;

  SearchPosts(this.repositories);

  Future<PostListResponseModel> call(
    String communityId,
    String? title,
    String? cursor,
  ) => repositories.searchPosts(communityId, title, cursor);
}
