import 'package:college_project/features/posts/data/models/post_liked_user_response_model.dart';

abstract class FetchPostReactionState {}

class PostReactionInitials extends FetchPostReactionState {}

class PostReactionLoading extends FetchPostReactionState {}

class PostReactionCountLoaded extends FetchPostReactionState {
  final int likeCount;

  // final bool likedByMe;

  PostReactionCountLoaded({
    required this.likeCount,
    // required this.likedByMe
  });
}

class PostReactionLoaded extends FetchPostReactionState {
  final int likeCount;
  final PostLikedUserResponseModel responseModel;

  PostReactionLoaded({required this.likeCount, required this.responseModel});

  PostReactionLoaded copyWith({
    int? likeCount,
    PostLikedUserResponseModel? responseModel,
  }) {
    return PostReactionLoaded(
      likeCount: likeCount ?? this.likeCount,
      responseModel: responseModel ?? this.responseModel,
    );
  }
}

class PostReactionError extends FetchPostReactionState {
  final String message;

  PostReactionError(this.message);
}
