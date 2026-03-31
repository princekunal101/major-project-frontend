abstract class SetUsernameEvent {}

class SetUsernameSubmitted extends SetUsernameEvent {
  final String userId;
  final String username;

  SetUsernameSubmitted(this.userId, this.username);
}
