import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/data/models/user_model.dart';

class UserRemoteDatasource {
  final DioClient _client;

  UserRemoteDatasource({required DioClient client}) : _client = client;

  Future<UserModel> getProfile() async {
    try {
      final response = await _client.get(ApiEndpoints.userProfile);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _client.patch(ApiEndpoints.userProfile, data: data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _client.post(ApiEndpoints.changePassword, data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
