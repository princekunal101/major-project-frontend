import 'package:college_project/features/posts/data/models/post_liked_user_model.dart';

class PostLikedUserResponse {
  final List<PostLikedUserModel> users;
  final String? nextCursor;
  final bool hasMore;

  PostLikedUserResponse({
    required this.users,
    this.nextCursor,
    this.hasMore = false,
  });
}
