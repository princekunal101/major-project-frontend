abstract class SearchPostsEvent {}

class SearchPostsSubmitted extends SearchPostsEvent {
  final String communityId;
  final String? title;
  final String? cursor;

  SearchPostsSubmitted({required this.communityId, this.title, this.cursor});
}
