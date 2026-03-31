import 'package:college_project/features/posts/data/models/post_list_item_model.dart';

class PostListResponse {
  final List<PostListItemModel> list;
  final String? nextCursor;
  final bool hasMore;

  PostListResponse({
    required this.list,
    this.nextCursor,
    required this.hasMore,
  });
}
