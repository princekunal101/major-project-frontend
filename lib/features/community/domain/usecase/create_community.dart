import 'package:college_project/core/utils/enums/community_shared_value.dart';
import 'package:college_project/core/utils/enums/community_topic.dart';
import 'package:college_project/core/utils/enums/community_type.dart';
import 'package:college_project/features/community/data/models/community_id_and_name_model.dart';
import 'package:college_project/features/community/domain/repositories/community_repositories.dart';

class CreateCommunity {
  final CommunityRepositories repositories;

  CreateCommunity(this.repositories);

  Future<CommunityIdAndNameModel> call(
    String topic,
    String sharedValue,
    String communityType,
    String communityName,
    String description,
    String displayName,
  ) => repositories.createCommunity(
    topic,
    sharedValue,
    communityType,
    communityName,
    description,
    displayName,
  );
}
