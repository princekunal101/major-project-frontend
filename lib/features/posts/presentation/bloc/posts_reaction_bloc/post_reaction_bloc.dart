import 'package:bloc/bloc.dart';
import 'package:college_project/features/posts/domain/usecase/post_reaction.dart';
import 'package:college_project/features/posts/presentation/bloc/posts_reaction_bloc/post_reaction_event.dart';
import 'package:college_project/features/posts/presentation/bloc/posts_reaction_bloc/post_reaction_state.dart';

class PostReactionBloc extends Bloc<PostReactionEvent, PostReactionState> {
  final PostReaction postReaction;
  final RemovePostReaction removePostReaction;

  PostReactionBloc(this.postReaction, this.removePostReaction)
    : super(PostReactionInitials()) {
    on<ReactionOnPost>(_reactOnPost);
    on<RemoveReactionOnPost>(_removeReaction);
  }

  Future<void> _reactOnPost(
    ReactionOnPost event,
    Emitter<PostReactionState> emit,
  ) async {
    emit(PostReactionLoading());
    try {
      await postReaction(event.postId, event.reactionType);
      emit(PostReactionSuccess(event.postId, event.reactionType));
    } catch (e) {
      emit(PostReactionFailure(e.toString()));
    }
  }

  Future<void> _removeReaction(
    RemoveReactionOnPost event,
    Emitter<PostReactionState> emit,
  ) async {
    emit(PostReactionLoading());
    try {
      await removePostReaction(event.postId);
      emit(PostReactionSuccess(event.postId, null));
    } catch (e) {
      emit(PostReactionFailure(e.toString()));
    }
  }
}
