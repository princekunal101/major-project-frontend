import 'package:college_project/features/profile/data/models/profile_result_model.dart';

abstract class GetProfileState {}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileLoaded extends GetProfileState {
  final ProfileResultModel profileResultModel;

  GetProfileLoaded(this.profileResultModel);
}

class GetProfileError extends GetProfileState {
  final String message;

  GetProfileError(this.message);
}
