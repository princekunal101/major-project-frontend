class PostListItem {
  final String postId;
  final String title;
  final String subTitle;
  final String body;
  final int likesCount;
  final int commentCount;
  final String createdAt;
  final String postedBy;

  PostListItem({
    required this.postId,
    required this.title,
    required this.subTitle,
    required this.body,
    required this.likesCount,
    required this.commentCount,
    required this.createdAt,
    required this.postedBy,
  });
}
