import 'package:bloc/bloc.dart';
import 'package:college_project/features/posts/domain/usecase/search_posts.dart';
import 'package:college_project/features/posts/presentation/bloc/search_posts_bloc/search_posts_event.dart';
import 'package:college_project/features/posts/presentation/bloc/search_posts_bloc/search_posts_state.dart';

class SearchPostsBloc extends Bloc<SearchPostsEvent, SearchPostsState> {
  final SearchPosts searchPosts;

  SearchPostsBloc(this.searchPosts) : super(SearchPostsInitial()) {
    on<SearchPostsSubmitted>((event, emit) async {
      emit(SearchPostsLoading());
      try {
        final response = await searchPosts(
          event.communityId,
          event.title,
          event.cursor,
        );
        emit(SearchPostsLoaded(response));
      } catch (error) {
        emit(SearchPostsFailure(error.toString()));
      }
    });
  }
}
