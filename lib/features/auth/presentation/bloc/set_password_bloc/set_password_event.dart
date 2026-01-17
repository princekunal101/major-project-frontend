abstract class SetPasswordEvent {}

class SetPasswordSubmitted extends SetPasswordEvent {
  final String email;
  final String createPassword;

  SetPasswordSubmitted(this.email, this.createPassword);
}
