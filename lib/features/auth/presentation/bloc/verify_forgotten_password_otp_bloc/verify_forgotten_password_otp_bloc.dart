import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/verify_forgot_password_otp.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_forgotten_password_otp_bloc/verify_forgotten_password_otp_event.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_forgotten_password_otp_bloc/verify_forgotten_password_otp_state.dart';

class VerifyForgottenPasswordOtpBloc
    extends
        Bloc<VerifyForgottenPasswordOtpEvent, VerifyForgottenPasswordOtpState> {
  final VerifyForgotPasswordOtp verifyForgotPasswordOtp;

  VerifyForgottenPasswordOtpBloc(this.verifyForgotPasswordOtp)
    : super(VerifyForgottenPasswordOtpInitial()) {
    on<VerifyForgottenPasswordOtpSubmitted>((event, emit) async {
      emit(VerifyForgottenPasswordOtpLoading());
      try {
        await verifyForgotPasswordOtp(event.email, event.otp);
        emit(VerifyForgottenPasswordOtpSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(VerifyForgottenPasswordOtpFailure(message));
      }
    });
  }
}
