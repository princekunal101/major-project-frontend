import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:college_project/features/posts/data/models/post_list_response_model.dart';
import 'package:college_project/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:college_project/features/posts/domain/entities/search_posts_params.dart';
import 'package:college_project/features/posts/domain/usecase/search_posts.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_event.dart';
import 'package:college_project/features/posts/presentation/bloc/fetch_posts_bloc/fetch_posts_state.dart';
import 'package:flutter/rendering.dart';

class FetchPostsBloc extends Bloc<FetchPostsEvent, FetchPostsState> {
  final SearchPosts searchPosts;
  final PostRepositoriesImpl repositories;

  FetchPostsBloc(this.searchPosts, this.repositories)
    : super(FetchPostInitial()) {
    on<SearchUserPosts>(_onSearchUser);
    on<SearchCommunityPosts>(_onSearchCommunity);
    on<FetchUserPosts>(_onFetchUser);
    on<FetchCommunityPosts>(_onFetchCommunity);
    on<ReloadPosts>(_onReload);
    on<LoadNextPosts>(_onLoadNext);
    on<ToggleLikes>(_onToggleLike);
  }

  Future<void> _onSearchUser(
    SearchUserPosts event,
    Emitter<FetchPostsState> emit,
  ) async {
    emit(FetchPostLoading());
    try {
      final result = await searchPosts(
        SearchPostsParams(
          userId: event.userId,
          title: event.titleQuery,
          cursor: event.cursor,
        ),
      );
      emit(FetchPostLoaded(result, originalEvent: event));
    } catch (error) {
      emit(FetchPostsError(error.toString()));
    }
  }

  Future<void> _onSearchCommunity(
    SearchCommunityPosts event,
    Emitter<FetchPostsState> emit,
  ) async {
    emit(FetchPostLoading());
    try {
      final result = await searchPosts(
        SearchPostsParams(
          communityId: event.communityId,
          title: event.titleQuery,
          cursor: event.cursor,
        ),
      );
      emit(FetchPostLoaded(result, originalEvent: event));
    } catch (e) {
      emit(FetchPostsError(e.toString()));
    }
  }

  Future<void> _onFetchUser(
    FetchUserPosts event,
    Emitter<FetchPostsState> emit,
  ) async {
    emit(FetchPostLoading());
    try {
      final result = await searchPosts(
        SearchPostsParams(userId: event.userId, cursor: event.cursor),
      );
      emit(FetchPostLoaded(result, originalEvent: event));
    } catch (e) {
      emit(FetchPostsError(e.toString()));
    }
  }

  Future<void> _onFetchCommunity(
    FetchCommunityPosts event,
    Emitter<FetchPostsState> emit,
  ) async {
    emit(FetchPostLoading());
    try {
      final result = await searchPosts(
        SearchPostsParams(communityId: event.communityId, cursor: event.cursor),
      );
      emit(FetchPostLoaded(result, originalEvent: event));
    } catch (e) {
      emit(FetchPostsError(e.toString()));
    }
  }

  Future<void> _onReload(
    ReloadPosts event,
    Emitter<FetchPostsState> emit,
  ) async {
    if (event.originalEvent is SearchUserPosts) {
      final ev = event.originalEvent as SearchUserPosts;
      add(SearchUserPosts(ev.userId, ev.titleQuery, ev.cursor));
    } else if (event.originalEvent is SearchCommunityPosts) {
      final ev = event.originalEvent as SearchCommunityPosts;
      add(SearchCommunityPosts(ev.communityId, ev.titleQuery, ev.cursor));
    } else if (event.originalEvent is FetchUserPosts) {
      final ev = event.originalEvent as FetchUserPosts;
      add(FetchUserPosts(userId: ev.userId, cursor: ev.cursor));
    } else if (event.originalEvent is FetchCommunityPosts) {
      final ev = event.originalEvent as FetchCommunityPosts;
      add(FetchCommunityPosts(communityId: ev.communityId, cursor: ev.cursor));
    }
  }

  Future<void> _onLoadNext(
    LoadNextPosts event,
    Emitter<FetchPostsState> emit,
  ) async {
    if (state is FetchPostLoaded) {
      final current = state as FetchPostLoaded;
      PostListResponseModel result;

      try {
        if (event.originalEvent is SearchUserPosts) {
          final ev = event.originalEvent as SearchUserPosts;
          result = await searchPosts(
            SearchPostsParams(
              userId: ev.userId,
              title: ev.titleQuery,
              cursor: ev.cursor,
            ),
          );
        } else if (event.originalEvent is SearchCommunityPosts) {
          final ev = event.originalEvent as SearchCommunityPosts;
          result = await searchPosts(
            SearchPostsParams(
              communityId: ev.communityId,
              title: ev.titleQuery,
              cursor: ev.cursor,
            ),
          );
        } else if (event.originalEvent is FetchUserPosts) {
          final ev = event.originalEvent as FetchUserPosts;
          result = await searchPosts(
            SearchPostsParams(
              userId: ev.userId,
              cursor: current.responseModel.cursor,
            ),
          );
        } else {
          final ev = event.originalEvent as FetchCommunityPosts;
          result = await searchPosts(
            SearchPostsParams(
              communityId: ev.communityId,
              cursor: current.responseModel.cursor,
            ),
          );
        }

        final mergedModel = current.responseModel.copyWith(
          items: [...current.responseModel.list, ...result.list],
          nextCursor: result.cursor,
          hasMore: result.hasMore,
        );
        emit(FetchPostLoaded(mergedModel, originalEvent: event.originalEvent));
      } catch (e) {
        emit(FetchPostsError(e.toString()));
      }
    }
  }

  Future _onToggleLike(ToggleLikes event, Emitter<FetchPostsState> emit) async {
    if (state is FetchPostLoaded) {
      final current = state as FetchPostLoaded;

      // Optimistic update
      final updatedItems = current.responseModel.list.map((post) {
        if (post.id == event.postId) {
          return post.copyWith(isLikedByMe: !event.currentlyLiked);
        }
        return post;
      }).toList();

      final updatedModel = current.responseModel.copyWith(
        items: updatedItems,
        // hasMore: current.responseModel.hasMore,
        // nextCursor: current.responseModel.nextCursor,
      );
      emit(FetchPostLoaded(updatedModel, originalEvent: current.originalEvent));

      // Call backend
      try {
        if (event.currentlyLiked) {
          await repositories.deletePostReaction(event.postId);
        } else {
          await repositories.postReaction(event.postId, "like");
        }
      } catch (e) {
        // Rollback if API fails
        emit(current);
      }
    }
  }
}
