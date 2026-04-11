import 'package:college_project/features/posts/domain/repositories/post_repositories.dart';

class CreatePost {
  final PostRepositories repositories;

  CreatePost(this.repositories);

  Future<void> call(
    String communityId,
    String title,
    String? subTitle,
    String body,
    String? tags, //array
    String? summaryTitle,
    String? summary,
    String contentType,
    String? imageUrl,
  ) => repositories.createNewPost(
    communityId,
    title,
    subTitle,
    body,
    tags,
    summaryTitle,
    summary,
    contentType,
    imageUrl,
  );
}
