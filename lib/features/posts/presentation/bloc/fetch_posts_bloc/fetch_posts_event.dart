abstract class FetchPostsEvent {}

class SearchUserPosts extends FetchPostsEvent {
  final String userId;
  final String titleQuery;
  final String? cursor;

  SearchUserPosts(this.userId, this.titleQuery, this.cursor);
}

class SearchCommunityPosts extends FetchPostsEvent {
  final String communityId;
  final String titleQuery;
  final String? cursor;

  SearchCommunityPosts(this.communityId, this.titleQuery, this.cursor);
}

class FetchUserPosts extends FetchPostsEvent {
  final String userId;
  final String? cursor;

  FetchUserPosts({required this.userId, this.cursor});
}

class FetchCommunityPosts extends FetchPostsEvent {
  final String communityId;
  final String? cursor;

  FetchCommunityPosts({required this.communityId, this.cursor});
}

class ReloadPosts extends FetchPostsEvent {
  final FetchPostsEvent originalEvent;

  ReloadPosts(this.originalEvent);
}

class LoadNextPosts extends FetchPostsEvent {
  final FetchPostsEvent originalEvent;
  final String cursor;

  LoadNextPosts({required this.originalEvent, required this.cursor});
}

class ToggleLikes extends FetchPostsEvent {
  final String postId;
  final bool currentlyLiked;

  ToggleLikes(this.postId, this.currentlyLiked);
}
