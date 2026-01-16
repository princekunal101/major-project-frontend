import 'package:college_project/features/auth/data/models/resend_otp_cool_down_model.dart';
import 'package:college_project/features/auth/domain/repositories/auth_repositories.dart';

class ResendOtp {
  final AuthRepositories repositories;

  ResendOtp(this.repositories);

  Future<ResendOtpCoolDownModel> call(String email) => repositories.resendOtp(email);
}
