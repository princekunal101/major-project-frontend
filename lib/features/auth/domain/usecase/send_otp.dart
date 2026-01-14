import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class SendOtp {
  final AuthRepositories repo;

  SendOtp(this.repo);

  Future<void> call(String email) => repo.sendOtp(email);
}
