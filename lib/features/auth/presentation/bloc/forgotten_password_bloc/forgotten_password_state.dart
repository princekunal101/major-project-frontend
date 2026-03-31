abstract class ForgottenPasswordState {}

class ForgottenPasswordInitial extends ForgottenPasswordState {}

class ForgottenPasswordLoading extends ForgottenPasswordState {}

class ForgottenPasswordSuccess extends ForgottenPasswordState {}

class ForgottenPasswordFailure extends ForgottenPasswordState {
  final String message;

  ForgottenPasswordFailure(this.message);
}
