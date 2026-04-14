import 'package:college_project/core/utils/enums/post_reaction_type.dart';

abstract class PostReactionState {}

class PostReactionInitials extends PostReactionState {}

class PostReactionLoading extends PostReactionState {}

class PostReactionSuccess extends PostReactionState {
  final String postId;
  final String? reactionType;

  PostReactionSuccess(this.postId, this.reactionType);
}

class PostReactionFailure extends PostReactionState {
  final String message;

  PostReactionFailure(this.message);
}
