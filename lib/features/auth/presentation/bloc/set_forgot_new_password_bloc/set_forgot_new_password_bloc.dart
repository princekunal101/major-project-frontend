import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/set_forgot_new_password.dart';
import 'package:college_project/features/auth/presentation/bloc/set_forgot_new_password_bloc/set_forgot_new_password_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_forgot_new_password_bloc/set_forgot_new_password_state.dart';

class SetForgotNewPasswordBloc
    extends Bloc<SetForgotNewPasswordEvent, SetForgotNewPasswordState> {
  final SetForgotNewPassword setForgotNewPassword;

  SetForgotNewPasswordBloc(this.setForgotNewPassword)
    : super(SetForgotNewPasswordInitial()) {
    on<SetForgotNewPasswordSubmitted>((event, emit) async {
      emit(SetForgotNewPasswordLoading());
      try {
        await setForgotNewPassword(event.email, event.newPassword);
        emit(SetForgotNewPasswordSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(SetForgotNewPasswordFailure(message));
      }
    });
  }
}
