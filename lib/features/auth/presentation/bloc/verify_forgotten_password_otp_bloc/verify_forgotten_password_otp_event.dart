abstract class VerifyForgottenPasswordOtpEvent {}

class VerifyForgottenPasswordOtpSubmitted
    extends VerifyForgottenPasswordOtpEvent {
  final String email;
  final String otp;

  VerifyForgottenPasswordOtpSubmitted(this.email, this.otp);
}
