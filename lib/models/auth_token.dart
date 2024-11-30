class AuthToken {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic>? result;
  final Map<String, dynamic>? error;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    this.result,
    this.error,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
