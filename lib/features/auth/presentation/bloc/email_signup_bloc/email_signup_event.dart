abstract class EmailSignupEvent {}

class SignupEmailSubmitted extends EmailSignupEvent {
  final String email;

  SignupEmailSubmitted({required this.email});
}
