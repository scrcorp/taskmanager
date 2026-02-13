import '../../../auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getProfile();
  Future<User> updateProfile(Map<String, dynamic> data);
  Future<void> changePassword(String currentPassword, String newPassword);
}
