import 'package:bloc/bloc.dart';
import 'package:college_project/features/feed/domain/usecase/get_all_posts_lists.dart';
import 'package:college_project/features/feed/domain/usecase/get_user_feeds_lists.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_event.dart';
import 'package:college_project/features/feed/presentation/bloc/feed_bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetAllPostsLists getAllPostsLists;
  final GetUserFeedsLists getUserFeedsLists;

  FeedBloc(this.getAllPostsLists, this.getUserFeedsLists)
    : super(FeedInitials()) {
    on<FetchUserFeed>(_onFetchUserFeed);
    on<FetchGlobalFeed>(_onFetchGlobalFeed);
    on<ReloadFeed>(_onReloadFeed);
    on<LoadNextFeed>(_onLoadNextFeed);
  }

  Future<void> _onFetchUserFeed(
    FetchUserFeed event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    try {
      final response = await getUserFeedsLists(event.cursor, event.limit);
      emit(FeedLoaded(responseModel: response, isUserFeed: true));
    } catch (error) {
      emit(FeedFailure(error.toString()));
    }
  }

  Future<void> _onFetchGlobalFeed(
    FetchGlobalFeed event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    try {
      final response = await getAllPostsLists(event.cursor, event.limit);
      emit(FeedLoaded(responseModel: response, isUserFeed: false));
    } catch (error) {
      emit(FeedFailure(error.toString()));
    }
  }

  Future<void> _onReloadFeed(ReloadFeed event, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      final current = state as FeedLoaded;
      emit(FeedReloading(current.responseModel));
      if (current.isUserFeed) {
        add(FetchUserFeed());
      } else {
        add(FetchGlobalFeed());
      }
    }
  }

  Future<void> _onLoadNextFeed(
    LoadNextFeed event,
    Emitter<FeedState> emit,
  ) async {
    if (state is FeedLoaded) {
      final current = state as FeedLoaded;
      if (!current.responseModel.hasMore) return;

      emit(FeedLoadingNext(current.responseModel));

      try {
        final response = current.isUserFeed
            ? await getUserFeedsLists(current.responseModel.nextCursor, 10)
            : await getAllPostsLists(current.responseModel.nextCursor, 10);

        // merged model
        final mergedModel = current.responseModel.copyWith(
          items: [...current.responseModel.listItem, ...response.listItem],
          nextCursor: response.nextCursor,
          hasMore: response.hasMore,
        );

        emit(
          FeedLoaded(
            responseModel: mergedModel,
            isUserFeed: current.isUserFeed,
          ),
        );
      } catch (error) {
        emit(FeedFailure(error.toString()));
      }
    }
  }
}
