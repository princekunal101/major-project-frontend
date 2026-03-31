import 'package:bloc/bloc.dart';
import 'package:college_project/features/community/domain/usecase/check_community_name_availability.dart';
import 'package:college_project/features/community/presentation/bloc/is_community_name_available_bloc/is_community_name_available_event.dart';
import 'package:college_project/features/community/presentation/bloc/is_community_name_available_bloc/is_community_name_available_state.dart';

class IsCommunityNameAvailableBloc
    extends Bloc<IsCommunityNameAvailableEvent, IsCommunityNameAvailableState> {
  final CheckCommunityNameAvailability nameAvailability;

  IsCommunityNameAvailableBloc(this.nameAvailability)
      :super(IsCommunityNameInitials()) {
    on<IsCommunityNameSubmitted>((event, emit) async {
      emit(IsCommunityNameLoading());

      try {
        final response = await nameAvailability(event.communityName);
        emit(IsCommunityNameSuccess(response));
      } catch (error) {
        emit(IsCommunityNameFailure(error.toString()));
      }
    });
  }
}