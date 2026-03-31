import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/forgotten_password.dart';
import 'package:college_project/features/auth/presentation/bloc/forgotten_password_bloc/forgotten_password_event.dart';
import 'package:college_project/features/auth/presentation/bloc/forgotten_password_bloc/forgotten_password_state.dart';

class ForgottenPasswordBloc
    extends Bloc<ForgottenPasswordEvent, ForgottenPasswordState> {
  final ForgottenPassword forgottenPassword;

  ForgottenPasswordBloc(this.forgottenPassword)
    : super(ForgottenPasswordInitial()) {
    on<ForgottenPasswordSubmitted>((event, emit) async {
      emit(ForgottenPasswordLoading());

      try {
        await forgottenPassword(event.email, event.isOtpMode);
        emit(ForgottenPasswordSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(ForgottenPasswordFailure(message));
      }
    });
  }
}
