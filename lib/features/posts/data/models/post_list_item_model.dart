import 'package:college_project/features/posts/domain/entities/post_list_item.dart';

class PostListItemModel extends PostListItem {
  PostListItemModel({
    required super.postId,

    required super.title,
    required super.subTitle,
    required super.body,
    required super.likesCount,
    required super.commentCount,
    required super.createdAt,
    required super.postedBy,
  });

  factory PostListItemModel.fromJson(Map<String, dynamic> json) {
    return PostListItemModel(
      postId: json['_id'],
      title: json['content']['title'],
      subTitle: json['content']['subTitle'],
      body: json['content']['body'],
      likesCount: json['likeCount'],
      commentCount: json['commentCount'],
      createdAt: json['createdAt'],
      postedBy: json['postedBy'],
    );
  }
}
