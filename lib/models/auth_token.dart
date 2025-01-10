class AuthToken {
  final String? accessToken;
  final String? refreshToken;
  final String? error;

  AuthToken({
    this.accessToken,
    this.refreshToken,
    this.error,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      error: json['error'] ?? '',
    );
  }
}
