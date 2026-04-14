import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:college_project/features/posts/data/models/post_liked_user_response_model.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_post_reaction_bloc/fetch_post_reaction_event.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_post_reaction_bloc/fetch_post_reaction_state.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_state.dart';

class FetchPostReactionBloc
    extends Bloc<FetchPostReactionEvent, FetchPostReactionState> {
  final PostRepositoriesImpl repositories;

  FetchPostReactionBloc(this.repositories) : super(PostReactionInitials()) {
    on<FetchLikeCount>(_onFetchLikedCount);
    on<FetchLikedUsers>(_onFetchLikedUsers);
  }

  Future<void> _onFetchLikedCount(
    FetchLikeCount event,
    Emitter<FetchPostReactionState> emit,
  ) async {
    emit(PostReactionLoading());
    try {
      final response = await repositories.fetchPostLikedCount(event.postId);
      if (state is PostReactionLoaded) {
        emit(
          (state as PostReactionLoaded).copyWith(likeCount: response.likeCount),
        );
      } else {
        emit(
          PostReactionLoaded(
            likeCount: response.likeCount,
            responseModel: PostLikedUserResponseModel(
              users: [],
              hasMore: false,
              nextCursor: null,
            ),
            // likedByMe: response.likedByMe,
          ),
        );
      }
    } catch (error) {
      emit(PostReactionError(error.toString()));
    }
  }

  Future<void> _onFetchLikedUsers(
    FetchLikedUsers event,
    Emitter<FetchPostReactionState> emit,
  ) async {
    emit(PostReactionLoading());
    try {
      final response = await repositories.fetchPostLikedUser(
        event.postId,
        event.cursor,
      );
      if (state is PostReactionLoaded) {
        final current = state as PostReactionLoaded;

        emit(
          current.copyWith(
            responseModel: current.responseModel.copyWith(
              items: [...current.responseModel.users, ...response.users],
              nextCursor: response.nextCursor,
              hasMore: response.hasMore,
            ),
          ),
        );
      } else {
        emit(
          PostReactionLoaded(
            likeCount: 0,
            responseModel: response,
            // likedByMe: response.likedByMe,
          ),
        );
      }
    } catch (error) {
      emit(PostReactionError(error.toString()));
    }
  }
}
