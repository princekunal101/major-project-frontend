abstract class SetDobState {}

class SetDobInitial extends SetDobState {}

class SetDobLoading extends SetDobState {}

class SetDobSuccess extends SetDobState {}

class SetDobFailure extends SetDobState {
  final String message;

  SetDobFailure(this.message);
}
