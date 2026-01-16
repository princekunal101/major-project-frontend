import 'package:college_project/features/auth/domain/entities/resend_otp_cool_down.dart';

class ResendOtpCoolDownModel extends ResendOtpCoolDown {
  ResendOtpCoolDownModel({required super.coolDownTimer});

  factory ResendOtpCoolDownModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpCoolDownModel(coolDownTimer: json['coolDown']);
  }
}
