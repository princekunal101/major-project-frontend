import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';
import 'package:college_project/features/community/data/models/community_id_and_name_model.dart';
import 'package:college_project/features/community/data/models/community_result_model.dart';
import 'package:college_project/features/community/data/models/is_community_name_available_model.dart';

abstract class CommunityRepositories {
  Future<CommunityIdAndNameModel> createCommunity(
    String topic,
    String sharedValue,
    String communityType,
    String communityName,
    String description,
    String displayName,
  );

  Future<IsCommunityNameAvailableModel> checkIsCommunityNameAvailable(
    String communityName,
  );

  Future<CommunityResultModel> getCommunityResult(String communityId);
}
