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

class ReloadFeed extends FeedEvent {}

class LoadNextFeed extends FeedEvent {}
