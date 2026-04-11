import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_event.dart';

abstract class FetchPostsState {}

class FetchPostInitial extends FetchPostsState {}

class FetchPostLoading extends FetchPostsState {}

class FetchPostLoaded extends FetchPostsState {
  final PostListResponseModel responseModel;
  final FetchPostsEvent originalEvent;

  FetchPostLoaded(this.responseModel, {required this.originalEvent});
}

class FetchPostsError extends FetchPostsState {
  final String message;

  FetchPostsError(this.message);
}
