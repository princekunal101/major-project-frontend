abstract class SetDobEvent {}

class SetDobEventSubmitted extends SetDobEvent {
  final String userId;
  final String dob;

  SetDobEventSubmitted(this.userId, this.dob);
}
