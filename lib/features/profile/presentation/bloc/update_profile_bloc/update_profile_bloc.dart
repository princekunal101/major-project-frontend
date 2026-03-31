import 'package:bloc/bloc.dart';
import 'package:college_project/features/profile/domain/usecase/update_profile.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_event.dart';
import 'package:college_project/features/profile/presentation/bloc/update_profile_bloc/update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfile updateProfile;

  UpdateProfileBloc(this.updateProfile) : super(UpdateProfileInitial()) {

    on<UpdateProfileSubmitted>((event, emit) async {
      emit(UpdateProfileLoading());

      try {
        await updateProfile(
          event.fullName,
          event.username,
          event.gender,
          event.bio,
          event.pronoun,
          event.dob,
          event.link,
        );
        emit(UpdateProfileSuccess());
      } catch (error) {
        emit(UpdateProfileFailure(error.toString()));
      }
    });

    on<UpdateProfileChanged>((event, emit) {
      emit(UpdateProfileChanging(event.value));
    });
  }
}
