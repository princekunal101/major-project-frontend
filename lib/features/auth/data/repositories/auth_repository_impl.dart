import 'package:college_project/core/models/create_username_suggestion.dart';
import 'package:college_project/core/services/secure_storage_service.dart';
import 'package:college_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:college_project/features/auth/data/models/resend_otp_cool_down_model.dart';
import 'package:college_project/features/auth/data/models/user_id_model.dart';
import 'package:college_project/features/auth/data/models/username_suggestion_model.dart';
import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl extends AuthRepositories {
  final AuthRemoteDataSource remote;
  final SecureStorageService storage;

  AuthRepositoryImpl(this.remote, this.storage);

  @override
  Future<void> signupWithEmail(String email) => remote.signupWithEmail(email);

  @override
  Future<void> verifyOtp(String email, String otp) =>
      remote.verifyOtp(email, otp);

  @override
  Future<ResendOtpCoolDownModel> resendOtp(String email) =>
      remote.resendOtp(email);

  @override
  Future<UserIdModel> setPassword(String email, String createPassword) =>
      remote.setPassword(email, createPassword);

  @override
  Future<void> login(String email, String password) async {
    final response = await remote.login(email, password);
    await storage.storeLoginData(
      response.accessToken,
      response.refreshToken,
      response.userId,
    );
  }

  @override
  Future<void> setDob(String userId, String dob) => remote.setDob(userId, dob);

  @override
  Future<void> setFullName(String userId, String fullName) =>
      remote.setFullName(userId, fullName);

  @override
  Future<CreateUsernameSuggestion> setUsername(
    String userId,
    String username,
  ) => remote.setUsername(userId, username);

  @override
  Future<void> forgottenPassword(String email, bool isOtpMode) =>
      remote.forgottenPassword(email, isOtpMode);

  @override
  Future<void> verifyForgotPasswordOtp(String email, String otp) =>
      remote.verifyForgotPasswordOtp(email, otp);

  @override
  Future<void> setForgotNewPassword(String email, String newPassword) async {
    final response = await remote.setForgotNewPassword(email, newPassword);
    await storage.storeLoginData(
      response.accessToken,
      response.refreshToken,
      response.userId,
    );
  }

  @override
  Future<void> acceptedTerms(String userId, bool acceptedTerms) async {
    final response = await remote.acceptedTerms(userId, acceptedTerms);
    await storage.storeLoginData(
      response.accessToken,
      response.refreshToken,
      response.userId,
    );
  }
}
