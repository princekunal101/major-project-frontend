abstract class FeedEvent {}

class FetchUserFeed extends FeedEvent {
  final String? cursor;
  final int? limit;

  FetchUserFeed({this.cursor, this.limit});
}

class FetchGlobalFeed extends FeedEvent {
  final String? cursor;
  final int? limit;

  FetchGlobalFeed({this.cursor, this.limit});
}

class ToggleLikes extends FeedEvent {
  final String postId;
  final bool currentlyLiked;

  ToggleLikes(this.postId, this.currentlyLiked);
}

class ReloadFeed extends FeedEvent {}

class LoadNextFeed extends FeedEvent {}
