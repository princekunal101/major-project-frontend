abstract class EmailSignupState {}

class EmailSignupInitial extends EmailSignupState {}

class EmailSignupLoading extends EmailSignupState {}

class EmailSignupSuccess extends EmailSignupState {}

class EmailSignupFailure extends EmailSignupState {
  final String message;

  EmailSignupFailure(this.message);
}
