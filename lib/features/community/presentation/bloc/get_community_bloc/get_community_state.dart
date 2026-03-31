import 'package:college_project/features/community/data/models/community_result_model.dart';

abstract class GetCommunityState {}

class GetCommunityInitials extends GetCommunityState {}

class GetCommunityLoading extends GetCommunityState {}

class GetCommunityLoaded extends GetCommunityState {
  final CommunityResultModel communityResultModel;

  GetCommunityLoaded(this.communityResultModel);
}

class GetCommunityError extends GetCommunityState {
  final String message;

  GetCommunityError(this.message);
}
