abstract class ResendOtpState {}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpSuccess extends ResendOtpState {
  final String response;

  ResendOtpSuccess(this.response);
}

class ResendOtpFailure extends ResendOtpState {
  final String message;

  ResendOtpFailure(this.message);
}
