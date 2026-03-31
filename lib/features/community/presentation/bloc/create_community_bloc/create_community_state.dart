import 'package:college_project/features/community/data/models/community_id_and_name_model.dart';

abstract class CreateCommunityState {}

class CreateCommunityInitials extends CreateCommunityState {}

class CreateCommunityLoading extends CreateCommunityState {}


class CreateCommunityChanging extends CreateCommunityState{
  final String? value;
  CreateCommunityChanging(this.value);
}


class CreateCommunitySuccess extends CreateCommunityState {
  final CommunityIdAndNameModel communityIdAndNameModel;

  CreateCommunitySuccess(this.communityIdAndNameModel);
}

class CreateCommunityFailure extends CreateCommunityState {
  final String message;

  CreateCommunityFailure(this.message);
}
