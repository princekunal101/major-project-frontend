import 'package:college_project/features/posts/domain/entities/post_list_item.dart';

class PostListItemModel extends PostListItem {
  PostListItemModel({
    required super.id,
    required super.title,
    super.subTitle,
    required super.body,
    super.summaryTitle,
    super.summary,
    required super.likesCount,
    required super.commentCount,
    required super.userId,
    super.userImg,
    required super.username,
    required super.communityId,
    required super.communityName,
    required super.createdAt,
    required super.isLikedByMe,
  });

  factory PostListItemModel.fromJson(Map<String, dynamic> json) {
    return PostListItemModel(
      id: json['_id'],
      title: json['content']['title'],
      subTitle: json['content']['subTitle'],
      body: json['content']['body'],
      summaryTitle: json['content']['subTitle'],
      likesCount: json['likeCount'],
      commentCount: json['commentCount'],
      userId: json['postedBy']['userId'],
      userImg: json['postedBy']['userImg'],
      username: json['postedBy']['username'],
      communityId: json['community']['communityId'],
      communityName: json['community']['communityName'],
      createdAt: json['createdAt'],
      isLikedByMe: json['isLikedByMe'],
    );
  }

  PostListItemModel copyWith({
    String? id,
    String? title,
    bool? isLikedByMe,
    bool? isFollowing,
  }) {
    return PostListItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body,
      subTitle: subTitle,
      summaryTitle: summaryTitle,
      summary: summary,
      likesCount: likesCount,
      commentCount: commentCount,
      userId: userId,
      username: username,
      communityId: communityId,
      communityName: communityName,
      createdAt: createdAt,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }
}
