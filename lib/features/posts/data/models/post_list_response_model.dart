import 'package:college_project/features/posts/data/models/post_list_item_model.dart';
import 'package:college_project/features/posts/domain/entities/post_list_response.dart';

class PostListResponseModel extends PostListResponse {
  PostListResponseModel({
    required super.list,
    super.nextCursor,
    required super.hasMore,
  });

  factory PostListResponseModel.fromJson(Map<String, dynamic> json) {
    return PostListResponseModel(
      list: (json['items'] as List)
          .map((e) => PostListItemModel.fromJson(e))
          .toList(),
      nextCursor: json['cursor'],
      hasMore: json['hasMore'],
    );
  }
}
