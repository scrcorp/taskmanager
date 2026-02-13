class SignupRequest {
  final String email;
  final String loginId;
  final String password;
  final String fullName;
  final String companyCode;
  final String language;

  const SignupRequest({
    required this.email,
    required this.loginId,
    required this.password,
    required this.fullName,
    required this.companyCode,
    this.language = 'en',
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'login_id': loginId,
    'password': password,
    'full_name': fullName,
    'company_code': companyCode,
    'language': language,
  };
}
