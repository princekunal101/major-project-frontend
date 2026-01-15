class AuthResult {
  final String accessToken;
  final String refreshToken;
  final String userId;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });
}
