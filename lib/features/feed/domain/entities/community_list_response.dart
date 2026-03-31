import 'package:college_project/features/feed/data/models/community_list_item_model.dart';

class CommunityListResponse {
  final List<CommunityListItemModel> listItem;
  // final String? nextCursor;
  // final bool hasMore;

  CommunityListResponse({
    required this.listItem,
    // this.nextCursor,
    // required this.hasMore,
  });
}
