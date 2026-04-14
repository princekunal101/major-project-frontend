import 'package:college_project/features/feed/domain/entities/feed_list_item.dart';

class FeedListItemModel extends FeedListItem {
  FeedListItemModel({
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
    required super.isFollowing,
    required super.isLikedByMe,
  });

  factory FeedListItemModel.fromJson(Map<String, dynamic> json) {
    return FeedListItemModel(
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
      isFollowing: json['community']['isFollowing'],
      isLikedByMe: json['isLikedByMe'],
    );
  }

  FeedListItemModel copyWith({
    String? id,
    String? title,
    bool? isLikedByMe,
    bool? isFollowing,
  }) {
    return FeedListItemModel(
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
      isFollowing: isFollowing ?? this.isFollowing,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }
}
