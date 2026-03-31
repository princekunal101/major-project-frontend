abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileChanging extends UpdateProfileState {
  final String? value;

  UpdateProfileChanging(this.value);
}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {}

class UpdateProfileFailure extends UpdateProfileState {
  final String message;

  UpdateProfileFailure(this.message);
}
