abstract class IsCommunityNameAvailableEvent {}

class IsCommunityNameSubmitted extends IsCommunityNameAvailableEvent {
  final String communityName;

  IsCommunityNameSubmitted(this.communityName);
}
