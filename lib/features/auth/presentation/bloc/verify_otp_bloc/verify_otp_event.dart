abstract class VerifyOtpEvent {}

class VerifyOtpSubmitted extends VerifyOtpEvent {
  final String email;
  final String otp;

  VerifyOtpSubmitted(this.email, this.otp);
}
