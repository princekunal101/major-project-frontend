import 'package:bloc/bloc.dart';
import 'package:college_project/features/community/domain/usecase/get_community.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_event.dart';
import 'package:college_project/features/community/presentation/bloc/get_community_bloc/get_community_state.dart';

class GetCommunityBloc extends Bloc<GetCommunityEvent, GetCommunityState> {
  final GetCommunity getCommunity;

  GetCommunityBloc(this.getCommunity) : super(GetCommunityInitials()) {
    on<GetCommunityResultLoad>((event, emit) async {
      emit(GetCommunityLoading());
      try {
        final response = await getCommunity(event.communityId);
        emit(GetCommunityLoaded(response));
      } catch (error) {
        emit(GetCommunityError(error.toString()));
      }
    });

    on<RetryCommunityResultLoad>(
      (event, emit) => add(GetCommunityResultLoad(event.communityId)),
    );
  }
}
