import 'package:college_project/features/feed/data/models/feed_list_item_model.dart';

class FeedListResponse {
  final List<FeedListItemModel> listItem;
  final String? nextCursor;
  final bool hasMore;

  FeedListResponse({
    required this.listItem,
    this.nextCursor,
    required this.hasMore,
  });



}