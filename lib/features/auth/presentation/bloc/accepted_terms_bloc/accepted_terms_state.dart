abstract class AcceptedTermsState {}

class AcceptedTermsInitial extends AcceptedTermsState {}

class AcceptedTermsLoading extends AcceptedTermsState {}

class AcceptedTermsSuccess extends AcceptedTermsState {}

class AcceptedTermsFailure extends AcceptedTermsState {
  final String message;

  AcceptedTermsFailure(this.message);
}
