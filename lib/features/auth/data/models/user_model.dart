import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.loginId,
    required super.fullName,
    required super.companyId,
    required super.role,
    required super.status,
    required super.language,
    required super.emailVerified,
    super.profileImage,
    super.joinDate,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      loginId: json['login_id'] as String,
      fullName: json['full_name'] as String,
      companyId: json['company_id'] as String,
      role: json['role'] as String? ?? 'staff',
      status: json['status'] as String? ?? 'active',
      language: json['language'] as String? ?? 'en',
      emailVerified: json['email_verified'] as bool? ?? false,
      profileImage: json['profile_image'] as String?,
      joinDate: json['join_date'] != null ? DateTime.parse(json['join_date'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'login_id': loginId,
      'full_name': fullName,
      'company_id': companyId,
      'role': role,
      'status': status,
      'language': language,
      'email_verified': emailVerified,
      'profile_image': profileImage,
      'join_date': joinDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
