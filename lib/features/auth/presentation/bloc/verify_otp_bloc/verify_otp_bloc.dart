import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/verify_otp.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_event.dart';
import 'package:college_project/features/auth/presentation/bloc/verify_otp_bloc/verify_otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtp verifyOtp;

  VerifyOtpBloc(this.verifyOtp) : super(VerifyOtpInitial()) {
    on<VerifyOtpSubmitted>((event, emit) async {
      emit(VerifyOtpLoading());
      try {
        await verifyOtp(event.email, event.otp);
        emit(VerifyOtpSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(VerifyOtpFailure(message));
      }
    });
  }
}
