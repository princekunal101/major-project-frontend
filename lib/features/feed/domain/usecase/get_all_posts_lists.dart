import 'package:college_project/features/feed/data/models/feed_list_response_model.dart';
import 'package:college_project/features/feed/domain/repositories/feed_repositories.dart';

class GetAllPostsLists {
  final FeedRepositories repositories;

  GetAllPostsLists(this.repositories);

  Future<FeedListResponseModel> call(String? cursor, int? limit) =>
      repositories.getAllPosts(cursor, limit);
}
