abstract class FetchPostReactionEvent {}

class FetchLikeCount extends FetchPostReactionEvent {
  final String postId;

  FetchLikeCount(this.postId);
}

class FetchLikedUsers extends FetchPostReactionEvent {
  final String postId;
  final String? cursor;

  FetchLikedUsers(this.postId, {this.cursor});
}
