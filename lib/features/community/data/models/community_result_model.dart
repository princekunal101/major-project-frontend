import 'package:college_project/features/community/domain/entities/community_result.dart';

class CommunityResultModel extends CommunityResult {
  CommunityResultModel({
    required super.communityId,
    required super.communityName,
    required super.displayName,
    required super.description,
    required super.communityType,
    required super.communityTopic,
    required super.sharedValue,
    super.bannerPicUrl,
    super.displayPicUrl,
    required super.createdBy,
    required super.postsCount,
    required super.totalMember,
  });

  factory CommunityResultModel.fromJson(Map<String, dynamic> json) {
    return CommunityResultModel(
      communityId: json['id'],
      communityName: json['communityName'],
      displayName: json['displayName'],
      description: json['description'],
      communityType: json['communityType'],
      communityTopic: json['communityTopic'],
      sharedValue: json['sharedValue'],
      createdBy: json['createdBy'],
      postsCount: json['totalPosts'],
      totalMember: json['totalMember'],
    );
  }
}
