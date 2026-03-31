import 'package:bloc/bloc.dart';
import 'package:college_project/core/error/failure.dart';
import 'package:college_project/features/auth/domain/usecase/accepted_terms.dart';
import 'package:college_project/features/auth/presentation/bloc/accepted_terms_bloc/accepted_terms_event.dart';
import 'package:college_project/features/auth/presentation/bloc/accepted_terms_bloc/accepted_terms_state.dart';

class AcceptedTermsBloc extends Bloc<AcceptedTermsEvent, AcceptedTermsState> {
  final AcceptedTerms acceptedTerms;

  AcceptedTermsBloc(this.acceptedTerms) :super(AcceptedTermsInitial()) {
    on<AcceptedTermsSubmitted>((event, emit) async {
      emit(AcceptedTermsLoading());
      try {
        await acceptedTerms(event.userId, event.acceptedTerms);
        emit(AcceptedTermsSuccess());
      } catch (error) {
        String message = mapExceptionToMessage(error);
        emit(AcceptedTermsFailure(message));
      }
    });
  }
}