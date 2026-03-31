import 'package:college_project/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:college_project/features/posts/domain/repositories/post_repositories.dart';

class PostRepositoriesImpl extends PostRepositories {
  final PostsRemoteDataSource remoteDataSource;

  PostRepositoriesImpl(this.remoteDataSource);

  @override
  Future<PostListResponseModel> searchPosts(
    String communityId,
    String? title,
    String? cursor,
  ) => remoteDataSource.postsResponse(communityId, title, cursor);
}
