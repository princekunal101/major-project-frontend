import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/core/models/create_username_suggestion.dart';
import 'package:college_project/features/auth/domain/usecase/set_username.dart';
import 'package:college_project/features/auth/presentation/bloc/set_username_bloc/set_username_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_username_bloc/set_username_state.dart';

class SetUsernameBloc extends Bloc<SetUsernameEvent, SetUsernameState> {
  final SetUsername setUsername;

  SetUsernameBloc(this.setUsername) : super(SetUsernameInitials()) {
    on<SetUsernameSubmitted>((event, emit) async {
      emit(SetUsernameLoading());
      try {
        final response = await setUsername(event.userId, event.username);
        switch (response.type) {
          case CreateSetUsernameType.success:
            emit(SetUsernameSuccess());
            break;
          case CreateSetUsernameType.conflict:
            emit(SetUsernameConflict(response.suggestionModel!));
            break;
        }
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(SetUsernameFailure(message));
      }
    });
  }
}
