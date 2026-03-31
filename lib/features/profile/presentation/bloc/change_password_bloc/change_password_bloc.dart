import 'package:bloc/bloc.dart';
import 'package:college_project/features/profile/domain/usecase/change_password.dart';
import 'package:college_project/features/profile/presentation/bloc/change_password_bloc/change_password_event.dart';
import 'package:college_project/features/profile/presentation/bloc/change_password_bloc/change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;

  ChangePasswordBloc(this.changePassword) : super(ChangePasswordInitials()) {
    on<ChangePasswordSubmitted>((event, emit) async {
      emit(ChangePasswordLoading());

      try {
        await changePassword(event.oldPassword, event.newPassword);
        emit(ChangePasswordSuccess());
      } catch (error) {
        emit(ChangePasswordFailure(error.toString()));
      }
    });
  }
}
