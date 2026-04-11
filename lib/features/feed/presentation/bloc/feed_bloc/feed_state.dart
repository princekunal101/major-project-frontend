import 'package:college_project/features/feed/data/models/feed_list_response_model.dart';

abstract class FeedState {}

class FeedInitials extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final FeedListResponseModel responseModel;
  final bool isUserFeed;

  FeedLoaded({required this.responseModel, this.isUserFeed = true});
}

class FeedFailure extends FeedState {
  final String message;

  FeedFailure(this.message);
}

class FeedReloading extends FeedState {
  final FeedListResponseModel responseModel;

  FeedReloading(this.responseModel);
}

class FeedLoadingNext extends FeedState {
  final FeedListResponseModel responseModel;

  FeedLoadingNext(this.responseModel);
}
