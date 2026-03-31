import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/set_dob.dart';
import 'package:college_project/features/auth/presentation/bloc/set_dob_bloc/set_dob_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_dob_bloc/set_dob_state.dart';

class SetDobBloc extends Bloc<SetDobEvent, SetDobState> {
  final SetDob setDob;

  SetDobBloc(this.setDob) : super(SetDobInitial()) {
    on<SetDobEventSubmitted>((event, emit) async {
      emit(SetDobLoading());
      try {
        await setDob(event.userId, event.dob);
        emit(SetDobSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(SetDobFailure(message));
      }
    });
  }
}
