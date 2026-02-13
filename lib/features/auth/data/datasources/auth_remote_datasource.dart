import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import '../models/token_response.dart';
import '../models/login_request.dart';
import '../models/signup_request.dart';

class AuthRemoteDatasource {
  final DioClient _client;

  AuthRemoteDatasource({required DioClient client}) : _client = client;

  Future<TokenResponse> login(LoginRequest request) async {
    try {
      final response = await _client.post(ApiEndpoints.login, data: request.toJson());
      return TokenResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<TokenResponse> signup(SignupRequest request) async {
    try {
      final response = await _client.post(ApiEndpoints.signup, data: request.toJson());
      return TokenResponse.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _client.post(ApiEndpoints.logout);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _client.get(ApiEndpoints.me);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> sendVerification(String email) async {
    try {
      await _client.post(ApiEndpoints.sendVerification, data: {'email': email});
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> verifyEmail(String email, String code) async {
    try {
      await _client.post(ApiEndpoints.verifyEmail, data: {'email': email, 'code': code});
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic e) {
    if (e is ServerException) return e;
    return ServerException(message: e.toString());
  }
}
