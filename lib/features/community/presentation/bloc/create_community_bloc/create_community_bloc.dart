import 'package:bloc/bloc.dart';
import 'package:college_project/features/community/domain/usecase/create_community.dart';
import 'package:college_project/features/community/presentation/bloc/create_community_bloc/create_community_event.dart';
import 'package:college_project/features/community/presentation/bloc/create_community_bloc/create_community_state.dart';

class CreateCommunityBloc
    extends Bloc<CreateCommunityEvent, CreateCommunityState> {
  final CreateCommunity createCommunity;

  CreateCommunityBloc(this.createCommunity) : super(CreateCommunityInitials()) {
    on<CreateCommunitySubmitted>((event, emit) async {
      emit(CreateCommunityLoading());

      try {
        final response = await createCommunity(
          event.topic,
          event.sharedValue,
          event.communityType,
          event.communityName,
          event.description,
          event.displayName,
        );
        emit(CreateCommunitySuccess(response));
      } catch (error) {
        emit(CreateCommunityFailure(error.toString()));
      }
    });

    on<CreateCommunityChanged>((event, emit) {
      emit(CreateCommunityChanging(event.value));
    });
  }
}
