import 'package:college_project/features/posts/data/models/post_liked_user_model.dart';
import 'package:college_project/features/posts/domain/entities/post_liked_user_response.dart';

class PostLikedUserResponseModel extends PostLikedUserResponse {
  PostLikedUserResponseModel({
    required super.users,
    super.nextCursor,
    super.hasMore,
  });

  factory PostLikedUserResponseModel.fromJson(Map<String, dynamic> json) {
    return PostLikedUserResponseModel(
      users: (json['items'] as List)
          .map((e) => PostLikedUserModel.fromJson(e))
          .toList(),
      nextCursor: json['nextCursor'],
      hasMore: json['hasMore'],
    );
  }

  PostLikedUserResponseModel copyWith({
    List<PostLikedUserModel>? items,
    String? nextCursor,
    bool? hasMore,
  }) {
    return PostLikedUserResponseModel(
      users: items ?? users,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
