abstract class ForgottenPasswordEvent {}

class ForgottenPasswordSubmitted extends ForgottenPasswordEvent {
  final String email;
  final bool isOtpMode;

  ForgottenPasswordSubmitted({required this.email, required this.isOtpMode});
}
