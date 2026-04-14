import 'package:college_project/features/posts/domain/entities/post_reaction_response.dart';

class PostReactionResponseModel extends PostReactionResponse {
  PostReactionResponseModel({
    required super.likeCount,
    // required super.isLikedByMe,
  });

  factory PostReactionResponseModel.fromJson(Map<String, dynamic> json) {
    return PostReactionResponseModel(
      likeCount: json['likesCount'],
      // isLikedByMe: json['isLikedByMe'],
    );
  }
}
