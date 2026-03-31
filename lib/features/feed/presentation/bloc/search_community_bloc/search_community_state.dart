import 'package:college_project/features/feed/data/models/community_list_response_model.dart';

abstract class SearchCommunityState {}

class SearchCommunityInitial extends SearchCommunityState {}

class SearchCommunityLoading extends SearchCommunityState {}

class SearchCommunityLoaded extends SearchCommunityState {
  final CommunityListResponseModel responseModel;

  SearchCommunityLoaded(this.responseModel);
}

class SearchCommunityFailure extends SearchCommunityState {
  final String message;

  SearchCommunityFailure(this.message);
}
