import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/set_full_name.dart';
import 'package:college_project/features/auth/presentation/bloc/set_full_name_bloc/set_full_name_event.dart';
import 'package:college_project/features/auth/presentation/bloc/set_full_name_bloc/set_full_name_state.dart';

class SetFullNameBloc extends Bloc<SetFullNameEvent, SetFullNameState> {
  final SetFullName setFullName;

  SetFullNameBloc(this.setFullName) : super(SetFullNameInitial()) {
    on<SetFullNameSubmitted>((event, emit) async {
      emit(SetFullNameLoading());
      try {
        await setFullName(event.userId, event.fullName);
        emit(SetFullNameSuccess());
      } catch (error) {
        final message = mapExceptionToMessage(error);
        emit(SetFullNameFailure(message));
      }
    });
  }
}
