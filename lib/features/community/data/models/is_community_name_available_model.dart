import 'package:college_project/features/community/domain/entities/is_community_name_available.dart';

class IsCommunityNameAvailableModel extends IsCommunityNameAvailable {
  IsCommunityNameAvailableModel({
    required super.isAvailable,
    required super.communityName,
  });

  factory IsCommunityNameAvailableModel.fromJson(Map<String, dynamic> json) {
    return IsCommunityNameAvailableModel(
      isAvailable: json['isAvailable'],
      communityName: json['communityName'],
    );
  }
}
