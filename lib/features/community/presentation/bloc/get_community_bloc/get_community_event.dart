abstract class GetCommunityEvent {}

class GetCommunityResultLoad extends GetCommunityEvent {
  final String communityId;

  GetCommunityResultLoad(this.communityId);
}

class RetryCommunityResultLoad extends GetCommunityEvent {
  final String communityId;

  RetryCommunityResultLoad(this.communityId);
}
