abstract class SetPasswordState {}

class SetPasswordInitial extends SetPasswordState {}

class SetPasswordLoading extends SetPasswordState {}

class SetPasswordSuccess extends SetPasswordState {
  final String response;

  SetPasswordSuccess(this.response);
}

class SetPasswordFailure extends SetPasswordState {
  final String message;

  SetPasswordFailure(this.message);
}
