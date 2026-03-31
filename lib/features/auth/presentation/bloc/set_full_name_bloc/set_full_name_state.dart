abstract class SetFullNameState {}

class SetFullNameInitial extends SetFullNameState {}

class SetFullNameLoading extends SetFullNameState {}

class SetFullNameSuccess extends SetFullNameState {}

class SetFullNameFailure extends SetFullNameState {
  final String message;

  SetFullNameFailure(this.message);
}
