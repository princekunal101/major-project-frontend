import 'package:college_project/features/feed/domain/entities/community_list_item.dart';

class CommunityListItemModel extends CommunityListItem {
  CommunityListItemModel({
    required super.communityId,
    required super.communityName,
    required super.displayName,
    required super.totalMember,
    required super.totalPosts,
    super.displayUrl,
  });

  factory CommunityListItemModel.fromJson(Map<String, dynamic> json) {
    return CommunityListItemModel(
      communityId: json['id'],
      communityName: json['communityName'],
      displayName: json['displayName'],
      totalMember: json['totalMember'],
      totalPosts: json['totalPosts'],
    );
  }
}
