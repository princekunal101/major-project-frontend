abstract class SetForgotNewPasswordState {}

class SetForgotNewPasswordInitial extends SetForgotNewPasswordState {}

class SetForgotNewPasswordLoading extends SetForgotNewPasswordState {}

class SetForgotNewPasswordSuccess extends SetForgotNewPasswordState {}

class SetForgotNewPasswordFailure extends SetForgotNewPasswordState {
  final String message;

  SetForgotNewPasswordFailure(this.message);
}
