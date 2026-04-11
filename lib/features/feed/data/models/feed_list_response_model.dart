import 'package:college_project/features/feed/data/models/feed_list_item_model.dart';
import 'package:college_project/features/feed/domain/entities/feed_list_item.dart';
import 'package:college_project/features/feed/domain/entities/feed_list_response.dart';

class FeedListResponseModel extends FeedListResponse {
  FeedListResponseModel({
    required super.listItem,
    super.nextCursor,
    required super.hasMore,
  });

  factory FeedListResponseModel.fromJson(Map<String, dynamic> json) {
    return FeedListResponseModel(
      listItem: (json['items'] as List)
          .map((e) => FeedListItemModel.fromJson(e))
          .toList(),
      nextCursor: json['nextCursor'],
      hasMore: json['hasMore'],
    );
  }

  FeedListResponseModel copyWith({
    List<FeedListItemModel>? items,
    String? nextCursor,
    bool? hasMore,
  }) {
    return FeedListResponseModel(
      listItem: items ?? listItem,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
