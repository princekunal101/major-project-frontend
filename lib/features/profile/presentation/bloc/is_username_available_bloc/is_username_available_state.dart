import 'package:college_project/features/profile/data/models/is_username_available_model.dart';

abstract class IsUsernameAvailableState {}

class IsUsernameAvailableInitial extends IsUsernameAvailableState {}

class IsUsernameAvailableLoading extends IsUsernameAvailableState {}

class IsUsernameAvailableSuccess extends IsUsernameAvailableState {
  final IsUsernameAvailableModel isUsernameAvailableModel;

  IsUsernameAvailableSuccess(this.isUsernameAvailableModel);
}

class IsUsernameAvailableFailure extends IsUsernameAvailableState {
  final String message;

  IsUsernameAvailableFailure(this.message);
}
