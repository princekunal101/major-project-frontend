import 'package:college_project/features/feed/data/models/community_list_item_model.dart';
import 'package:college_project/features/feed/domain/entities/community_list_response.dart';

class CommunityListResponseModel extends CommunityListResponse {
  CommunityListResponseModel({
    required super.listItem,
    // super.nextCursor,
    // required super.hasMore,
  });

  factory CommunityListResponseModel.fromJson(Map<String, dynamic> json) {
    return CommunityListResponseModel(
      listItem: (json['items'] as List)
          .map((e) => CommunityListItemModel.fromJson(e))
          .toList(),
      // nextCursor: json['nextCursor'],
      // hasMore: json['hasMore'],
    );
  }
}
