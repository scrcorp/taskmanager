import '../entities/user.dart';
import '../../data/models/login_request.dart';
import '../../data/models/signup_request.dart';

abstract class AuthRepository {
  Future<User> login(LoginRequest request);
  Future<User> signup(SignupRequest request);
  Future<void> logout();
  Future<User> getCurrentUser();
  Future<void> sendVerification(String email);
  Future<void> verifyEmail(String email, String code);
  Future<bool> isAuthenticated();
}
