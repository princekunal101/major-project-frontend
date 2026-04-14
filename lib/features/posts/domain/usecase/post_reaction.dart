import 'package:college_project/core/utils/enums/post_reaction_type.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/domain/repositories/post_repositories.dart';

class PostReaction {
  final PostRepositories postRepositories;

  PostReaction(this.postRepositories);

  Future<void> call(String postId, String? reactType) =>
      postRepositories.postReaction(postId, reactType!);
}

class RemovePostReaction {
  final PostRepositories repositories;

  RemovePostReaction(this.repositories);

  Future<void> call(String postId) => repositories.deletePostReaction(postId);
}
