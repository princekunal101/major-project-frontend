import 'package:college_project/features/posts/domain/entities/post_liked_user.dart';

class PostLikedUserModel extends PostLikedUser {
  PostLikedUserModel({
    required super.id,
    required super.postId,
    required super.userId,
    required super.username,
    required super.displayName,
    required super.reactType,
    // required super.description,
  });

  factory PostLikedUserModel.fromJson(Map<String, dynamic> json) {
    return PostLikedUserModel(
      id: json['_id'],
      postId: json['postId'],
      userId: json['userData']['userId'],
      username: json['userData']['username'],
      displayName: json['userData']['displayName'],
      reactType: json['reactType']
      // description: json['description'],
    );
  }
}
