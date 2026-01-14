abstract class LoginEvent {}

class LoginEmailPasswordSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginEmailPasswordSubmitted(this.email, this.password);
}
