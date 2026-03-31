abstract class ChangePasswordState {}

class ChangePasswordInitials extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String message;

  ChangePasswordFailure(this.message);
}
