import 'package:college_project/features/profile/domain/entities/profile_result.dart';

class ProfileResultModel extends ProfileResult {
  ProfileResultModel({
    required super.id,
    required super.userId,
    super.name,
    super.username,
    super.bio,
    super.link,
    super.gender,
    super.dob,
    super.pronoun,
    super.bannerUrl,
    super.profileImageUrl,
    super.music,
    super.isVerified,
    super.isProfessional,
    super.showThreads,
    super.creationDate,
  });

  factory ProfileResultModel.fromJson(Map<String, dynamic> json) {
    return ProfileResultModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      username: json['username'],
      bio: json['bio'],
      link: json['link'],
      gender: json['gender'],
      dob: json['dob'],
      pronoun: json['pronoun'],
      bannerUrl: json['bannerUrl'],
      profileImageUrl: json['profileImage'],
      music: json['music'],
      isVerified: json['isVerified'],
      isProfessional: json['isProfessional'],
      showThreads: json['showThreads'],
      creationDate: json['creationDate'],
    );
  }
}
