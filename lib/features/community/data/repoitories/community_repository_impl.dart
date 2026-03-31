import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';
import 'package:college_project/features/community/data/datasources/community_remote_data_source.dart';
import 'package:college_project/features/community/data/models/community_id_and_name_model.dart';
import 'package:college_project/features/community/data/models/community_result_model.dart';
import 'package:college_project/features/community/data/models/is_community_name_available_model.dart';
import 'package:college_project/features/community/domain/repositories/community_repositories.dart';

class CommunityRepositoryImpl extends CommunityRepositories {
  final CommunityRemoteDataSource remoteDataSource;

  CommunityRepositoryImpl(this.remoteDataSource);

  @override
  Future<IsCommunityNameAvailableModel> checkIsCommunityNameAvailable(
    String communityName,
  ) => remoteDataSource.checkCommunityNameAvailability(communityName);

  @override
  Future<CommunityIdAndNameModel> createCommunity(
    String topic,
    String sharedValue,
    String communityType,
    String communityName,
    String description,
    String? displayName,
  ) {
    final data = <String, dynamic>{};
    data['communityTopic'] = topic;
    data['sharedValue'] = sharedValue;
    data['communityType'] = communityType;
    data['communityName'] = communityName;
    data['description'] = description;
    if (displayName != null) data['displayName'] = displayName;

    return remoteDataSource.createCommunity(data);
  }

  @override
  Future<CommunityResultModel> getCommunityResult(String communityId) =>
      remoteDataSource.getCommunityById(communityId);
}
