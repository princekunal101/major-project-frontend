class CommunityListItem {
  final String communityId;
  final String communityName;
  final String displayName;
  final int totalMember;
  final int totalPosts;
  final String? displayUrl;

  CommunityListItem({
    required this.communityId,
    required this.communityName,
    required this.displayName,
    required this.totalMember,
    required this.totalPosts,
    this.displayUrl,
  });
}
