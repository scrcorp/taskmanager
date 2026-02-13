class LoginRequest {
  final String loginId;
  final String password;

  const LoginRequest({required this.loginId, required this.password});

  Map<String, dynamic> toJson() => {
    'login_id': loginId,
    'password': password,
  };
}
