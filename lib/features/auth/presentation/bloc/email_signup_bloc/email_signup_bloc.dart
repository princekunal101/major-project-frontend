import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/signup_with_email.dart';
import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_event.dart';
import 'package:college_project/features/auth/presentation/bloc/email_signup_bloc/email_signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailSignupBloc extends Bloc<EmailSignupEvent, EmailSignupState> {
  final SignupWithEmail signupWithEmail;

  EmailSignupBloc(this.signupWithEmail) : super(EmailSignupInitial()) {
    on<SignupEmailSubmitted>((event, emit) async {
      emit(EmailSignupLoading());
      try {
        await signupWithEmail(event.email);
        emit(EmailSignupSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(EmailSignupFailure(message));
      }
    });
  }
}
