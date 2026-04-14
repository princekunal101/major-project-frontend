import 'package:college_project/features/posts/data/models/post_list_item_model.dart';

class PostListResponse {
  final List<PostListItemModel> list;
  final String? cursor;
  final bool hasMore;

  PostListResponse({
    required this.list,
    this.cursor,
    required this.hasMore,
  });
}
