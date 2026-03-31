abstract class SetForgotNewPasswordEvent {}

class SetForgotNewPasswordSubmitted extends SetForgotNewPasswordEvent {
  final String email;
  final String newPassword;

  SetForgotNewPasswordSubmitted(this.email, this.newPassword);
}
