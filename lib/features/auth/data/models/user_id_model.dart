import 'package:college_project/features/auth/domain/entities/user_id.dart';

class UserIdModel extends UserId {
  UserIdModel({required super.userId});

  factory UserIdModel.fromJson(Map<String, dynamic> json) {
    return UserIdModel(userId: json['userId']);
  }
}
