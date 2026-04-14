class PostListItem {
  final String id;
  final String title;
  final String? subTitle;
  final String body;
  final String? summaryTitle;
  final String? summary;
  final int likesCount;
  final int commentCount;
  final String userId;
  final String? userImg;
  final String username;
  final String communityId;
  final String communityName;
  final String createdAt;
  final bool isLikedByMe;

  PostListItem({
    required this.id,
    required this.title,
    this.subTitle,
    required this.body,
    this.summaryTitle,
    this.summary,
    required this.likesCount,
    required this.commentCount,
    required this.userId,
    this.userImg,
    required this.username,
    required this.communityId,
    required this.communityName,
    required this.createdAt,
    required this.isLikedByMe,
  });
}
