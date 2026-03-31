import 'package:bloc/bloc.dart';
import 'package:college_project/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:college_project/features/profile/domain/repositories/profile_repositories.dart';
import 'package:college_project/features/profile/domain/usecase/profile_user.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/get_profile_bloc/get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final ProfileUser profileUser;

  GetProfileBloc(this.profileUser) : super(GetProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(GetProfileLoading());
      try {
        final profile = await profileUser();
        emit(GetProfileLoaded(profile));
      } catch (error) {
        emit(GetProfileError(error.toString()));
      }
    });

    on<RetryLoadProfile>((event, emit) => add(LoadProfile()));
  }
}
