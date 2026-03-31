import 'package:bloc/bloc.dart';
import 'package:college_project/features/feed/domain/usecase/get_community_lists.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_event.dart';
import 'package:college_project/features/feed/presentation/bloc/search_community_bloc/search_community_state.dart';

class SearchCommunityBloc
    extends Bloc<SearchCommunityEvent, SearchCommunityState> {
  final GetCommunityLists communityLists;

  SearchCommunityBloc(this.communityLists) : super(SearchCommunityInitial()) {
    on<SearchCommunityStringSubmitted>((event, emit) async {
      emit(SearchCommunityLoading());

      try {
        final response = await communityLists(
          event.communityName,
          event.displayName,
        );
        emit(SearchCommunityLoaded(response));
      } catch (error) {
        emit(SearchCommunityFailure(error.toString()));
      }
    });
  }
}
