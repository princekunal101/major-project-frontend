import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/set_password.dart';
import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_password_bloc/set_password_state.dart';

class SetPasswordBloc extends Bloc<SetPasswordEvent, SetPasswordState> {
  final SetPassword setPassword;

  SetPasswordBloc(this.setPassword) : super(SetPasswordInitial()) {
    on<SetPasswordSubmitted>((event, emit) async {
      emit(SetPasswordLoading());
      try {
        final response = await setPassword(event.email, event.createPassword);
        emit(SetPasswordSuccess(response.userId));
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(SetPasswordFailure(message));
      }
    });
  }
}
