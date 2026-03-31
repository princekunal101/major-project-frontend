import 'package:college_project/features/community/domain/entities/community_id_name.dart';

class CommunityIdAndNameModel extends CommunityIdName {
  CommunityIdAndNameModel({
    required super.communityId,
    required super.communityName,
  });

  factory CommunityIdAndNameModel.fomJson(Map<String, dynamic> json) {
    return CommunityIdAndNameModel(
      communityId: json['communityId'],
      communityName: json['communityName'],
    );
  }
}
