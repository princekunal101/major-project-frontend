import 'package:college_project/features/profile/domain/usecase/check_is_username_available.dart';
import 'package:college_project/features/profile/presentation/bloc/is_username_available_bloc/is_username_available_event.dart';
import 'package:college_project/features/profile/presentation/bloc/is_username_available_bloc/is_username_available_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsUsernameAvailableBloc
    extends Bloc<IsUsernameAvailableEvent, IsUsernameAvailableState> {
  final CheckIsUsernameAvailable checkIsUsernameAvailable;

  IsUsernameAvailableBloc(this.checkIsUsernameAvailable)
    : super(IsUsernameAvailableInitial()) {
    on<IsUsernameAvailableSubmitted>((event, emit) async {
      emit(IsUsernameAvailableLoading());

      try {
        final response = await checkIsUsernameAvailable(event.username);
        emit(IsUsernameAvailableSuccess(response));
      } catch (error) {
        emit(IsUsernameAvailableFailure(error.toString()));
      }
    });
  }
}
