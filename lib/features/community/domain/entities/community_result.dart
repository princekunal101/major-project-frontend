class CommunityResult {
  final String communityName;
  final String displayName;
  final String communityId;
  final String description;
  final String communityType;
  final String communityTopic;
  final String sharedValue;
  final String createdBy;
  final String? bannerPicUrl;
  final String? displayPicUrl;
  final int postsCount;
  final int totalMember;

  CommunityResult({
    required this.communityName,
    required this.displayName,
    required this.communityId,
    required this.description,
    required this.communityType,
    required this.communityTopic,
    required this.sharedValue,
    this.bannerPicUrl,
    this.displayPicUrl,
    required this.createdBy,
    required this.postsCount,
    required this.totalMember
  });
}