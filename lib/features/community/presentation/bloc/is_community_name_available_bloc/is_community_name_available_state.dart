import 'package:college_project/features/community/data/models/is_community_name_available_model.dart';

abstract class IsCommunityNameAvailableState {}

class IsCommunityNameInitials extends IsCommunityNameAvailableState {}

class IsCommunityNameLoading extends IsCommunityNameAvailableState {}

class IsCommunityNameSuccess extends IsCommunityNameAvailableState {
  final IsCommunityNameAvailableModel availableModel;

  IsCommunityNameSuccess(this.availableModel);
}

class IsCommunityNameFailure extends IsCommunityNameAvailableState {
  final String message;

  IsCommunityNameFailure(this.message);
}
