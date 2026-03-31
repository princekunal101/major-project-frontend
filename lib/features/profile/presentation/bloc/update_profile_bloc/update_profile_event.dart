abstract class UpdateProfileEvent {}

class UpdateProfileSubmitted extends UpdateProfileEvent {
  final String? fullName;
  final String? username;
  final String? gender;
  final String? bio;
  final String? pronoun;
  final String? dob;
  final String? link;

  UpdateProfileSubmitted(
    this.fullName,
    this.username,
    this.gender,
    this.bio,
    this.pronoun,
    this.dob,
    this.link,
  );
}

class UpdateProfileChanged extends UpdateProfileEvent {
  final String? value;

  UpdateProfileChanged(this.value);
}
