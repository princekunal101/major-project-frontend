import 'package:college_project/features/posts/data/models/post_list_item_model.dart';
import 'package:college_project/features/posts/domain/entities/post_list_response.dart';

class PostListResponseModel extends PostListResponse {
  PostListResponseModel({
    required super.list,
    super.cursor,
    required super.hasMore,
  });

  factory PostListResponseModel.fromJson(Map<String, dynamic> json) {
    return PostListResponseModel(
      list: (json['items'] as List)
          .map((e) => PostListItemModel.fromJson(e))
          .toList(),
      cursor: json['nextCursor'],
      hasMore: json['hasMore'],
    );
  }

  PostListResponseModel copyWith({
    List<PostListItemModel>? items,
    String? nextCursor,
    bool? hasMore,
  }) {
    return PostListResponseModel(
      list: items ?? list,
      cursor: nextCursor ?? cursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
