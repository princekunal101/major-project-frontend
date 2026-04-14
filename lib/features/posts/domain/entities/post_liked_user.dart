class PostLikedUser {
  final String id;
  final String postId;
  final String userId;
  final String username;
  final String? displayName;
  final String reactType;

  // final String? description;

  PostLikedUser({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.displayName,
    required this.reactType,
    // this.description,
  });
}
