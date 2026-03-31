abstract class AcceptedTermsEvent {}

class AcceptedTermsSubmitted extends AcceptedTermsEvent {
  final String userId;
  final bool acceptedTerms;

  AcceptedTermsSubmitted({required this.userId, required this.acceptedTerms});
}
