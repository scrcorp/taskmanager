import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _remoteDatasource;

  UserRepositoryImpl({required UserRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<User> getProfile() => _remoteDatasource.getProfile();

  @override
  Future<User> updateProfile(Map<String, dynamic> data) => _remoteDatasource.updateProfile(data);

  @override
  Future<void> changePassword(String currentPassword, String newPassword) =>
      _remoteDatasource.changePassword(currentPassword, newPassword);
}
