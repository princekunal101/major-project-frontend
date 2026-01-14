import 'package:college_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:college_project/features/auth/domain/entities/user.dart';
import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl extends AuthRepositories {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<void> sendOtp(String email) => remote.sendOtp(email);

  @override
  Future<void> verifyOtp(String email, String otp) =>
      remote.verifyOtp(email, otp);

  @override
  Future<User> login(String email, String password) async {
    final userModel = remote.login(email, password);
    return userModel;
  }
}
