import 'user_model.dart';

class TokenResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel? user;
  final String? message;

  const TokenResponse({
    required this.accessToken,
    required this.refreshToken,
    this.user,
    this.message,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: json['user'] != null ? UserModel.fromJson(json['user'] as Map<String, dynamic>) : null,
      message: json['message'] as String?,
    );
  }
}
