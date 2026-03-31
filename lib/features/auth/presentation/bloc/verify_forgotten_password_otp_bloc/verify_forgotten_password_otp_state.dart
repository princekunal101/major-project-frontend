abstract class VerifyForgottenPasswordOtpState {}

class VerifyForgottenPasswordOtpInitial
    extends VerifyForgottenPasswordOtpState {}

class VerifyForgottenPasswordOtpLoading
    extends VerifyForgottenPasswordOtpState {}

class VerifyForgottenPasswordOtpSuccess
    extends VerifyForgottenPasswordOtpState {}

class VerifyForgottenPasswordOtpFailure
    extends VerifyForgottenPasswordOtpState {
  final String message;

  VerifyForgottenPasswordOtpFailure(this.message);
}
