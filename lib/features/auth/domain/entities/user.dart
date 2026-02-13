class User {
  final String id;
  final String email;
  final String loginId;
  final String fullName;
  final String companyId;
  final String role;
  final String status;
  final String language;
  final bool emailVerified;
  final String? profileImage;
  final DateTime? joinDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.loginId,
    required this.fullName,
    required this.companyId,
    required this.role,
    required this.status,
    required this.language,
    required this.emailVerified,
    this.profileImage,
    this.joinDate,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isAdmin => role == 'admin';
  bool get isManager => role == 'manager' || role == 'admin';
  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';
}
