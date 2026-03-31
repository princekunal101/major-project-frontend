import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class AcceptedTerms {
  final AuthRepositories repositories;

  AcceptedTerms(this.repositories);

  Future<void> call(String userId, bool acceptedTerms) =>
      repositories.acceptedTerms(userId, acceptedTerms);
}
