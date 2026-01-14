import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_event.dart';
import 'package:college_project/features/auth/presentation/bloc/login_bloc/login_state.dart';

import "package:bloc/bloc.dart";

import '../../../domain/usecase/login_user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc(this.loginUser) : super(LoginInitial()) {
    on<LoginEmailPasswordSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await loginUser(event.email, event.password);
        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
