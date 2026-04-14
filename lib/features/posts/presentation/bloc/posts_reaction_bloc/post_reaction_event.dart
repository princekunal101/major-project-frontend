import 'package:college_project/core/utils/enums/post_reaction_type.dart';

abstract class PostReactionEvent {}

class ReactionOnPost extends PostReactionEvent {
  final String postId;
  final String? reactionType;

  ReactionOnPost(this.postId, this.reactionType);
}

class RemoveReactionOnPost extends PostReactionEvent {
  final String postId;

  RemoveReactionOnPost(this.postId);
}
