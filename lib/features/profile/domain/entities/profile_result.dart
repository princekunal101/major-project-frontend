class ProfileResult {
  final String id;
  final String userId;
  final String? name;
  final String? username;
  final String? gender;
  final String? bio;
  final String? music;
  final String? link;
  final String? pronoun;
  final String? bannerUrl;
  final String? profileImageUrl;
  final String? dob;
  final bool? isProfessional;
  final bool? isVerified;
  final bool? showThreads;
  final String? creationDate;

  ProfileResult({
    required this.id,
    required this.userId,
    this.name,
    this.username,
    this.gender,
    this.bio,
    this.music,
    this.link,
    this.pronoun,
    this.bannerUrl,
    this.profileImageUrl,
    this.isVerified,
    this.isProfessional,
    this.showThreads,
    this.dob,
    this.creationDate,
  });
}
