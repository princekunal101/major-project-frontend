import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/resend_otp.dart';
import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_event.dart';
import 'package:college_project/features/auth/presentation/bloc/resend_otp_bloc/resend_otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  final ResendOtp resendOtp;

  ResendOtpBloc(this.resendOtp) : super(ResendOtpInitial()) {
    on<ResendOtpSubmitted>((event, emit) async {
      emit(ResendOtpLoading());
      try {
        final response = await resendOtp(event.email);
        emit(ResendOtpSuccess(response.coolDownTimer));
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(ResendOtpFailure(message));
      }
    });
  }
}
