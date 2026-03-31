abstract class SearchCommunityEvent {}

class SearchCommunityStringSubmitted extends SearchCommunityEvent {
  final String? communityName;
  final String? displayName;

  SearchCommunityStringSubmitted({this.communityName, this.displayName});
}
