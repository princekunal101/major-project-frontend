abstract class IsUsernameAvailableEvent {}

class IsUsernameAvailableSubmitted extends IsUsernameAvailableEvent {
  final String username;

  IsUsernameAvailableSubmitted(this.username);
}
