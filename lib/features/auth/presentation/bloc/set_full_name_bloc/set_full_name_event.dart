abstract class SetFullNameEvent {}

class SetFullNameSubmitted extends SetFullNameEvent {
  final String userId;
  final String fullName;

  SetFullNameSubmitted(this.userId, this.fullName);
}
