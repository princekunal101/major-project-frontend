abstract class ResendOtpEvent {}

class ResendOtpSubmitted extends ResendOtpEvent {
  final String email;

  ResendOtpSubmitted(this.email);
}
