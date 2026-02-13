import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request.dart';
import '../models/signup_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required TokenStorage tokenStorage,
  })  : _remoteDatasource = remoteDatasource,
        _tokenStorage = tokenStorage;

  @override
  Future<User> login(LoginRequest request) async {
    final response = await _remoteDatasource.login(request);
    await _tokenStorage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    if (response.user != null) return response.user!;
    return getCurrentUser();
  }

  @override
  Future<User> signup(SignupRequest request) async {
    final response = await _remoteDatasource.signup(request);
    await _tokenStorage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    if (response.user != null) return response.user!;
    return getCurrentUser();
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDatasource.logout();
    } finally {
      await _tokenStorage.clearTokens();
    }
  }

  @override
  Future<User> getCurrentUser() async {
    return _remoteDatasource.getCurrentUser();
  }

  @override
  Future<void> sendVerification(String email) async {
    await _remoteDatasource.sendVerification(email);
  }

  @override
  Future<void> verifyEmail(String email, String code) async {
    await _remoteDatasource.verifyEmail(email, code);
  }

  @override
  Future<bool> isAuthenticated() async {
    return _tokenStorage.hasTokens();
  }
}
