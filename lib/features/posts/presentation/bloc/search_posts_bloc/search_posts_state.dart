import 'package:college_project/features/posts/data/models/post_list_response_model.dart';

abstract class SearchPostsState {}

class SearchPostsInitial extends SearchPostsState {}

class SearchPostsLoading extends SearchPostsState {}

class SearchPostsLoaded extends SearchPostsState {
  final PostListResponseModel responseModel;

  SearchPostsLoaded(this.responseModel);
}

class SearchPostsFailure extends SearchPostsState {
  final String message;

  SearchPostsFailure(this.message);
}
