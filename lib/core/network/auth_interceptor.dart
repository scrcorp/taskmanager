import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../config/app_config.dart';
import '../constants/api_endpoints.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _dio;
  bool _isRefreshing = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})> _queue = [];

  AuthInterceptor({
    required TokenStorage tokenStorage,
    required Dio dio,
  })  : _tokenStorage = tokenStorage,
        _dio = dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final noAuthPaths = [
      ApiEndpoints.login,
      ApiEndpoints.signup,
      ApiEndpoints.refresh,
      ApiEndpoints.sendVerification,
      ApiEndpoints.verifyEmail,
    ];

    final path = options.path.replaceFirst(AppConfig.baseUrl, '');
    if (noAuthPaths.contains(path)) {
      return handler.next(options);
    }

    final token = await _tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final path = err.requestOptions.path.replaceFirst(AppConfig.baseUrl, '');
    if (path == ApiEndpoints.refresh || path == ApiEndpoints.login) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      _queue.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        await _tokenStorage.clearTokens();
        return handler.next(err);
      }

      final response = await _dio.post(
        '${AppConfig.baseUrl}${ApiEndpoints.refresh}',
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'] as String;
      final newRefreshToken = response.data['refresh_token'] as String;

      await _tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      // Retry original request
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await _dio.fetch(err.requestOptions);
      handler.resolve(retryResponse);

      // Retry queued requests
      for (final queued in _queue) {
        queued.options.headers['Authorization'] = 'Bearer $newAccessToken';
        _dio.fetch(queued.options).then(
          (r) => queued.handler.resolve(r),
          onError: (e) => queued.handler.reject(e as DioException),
        );
      }
    } catch (e) {
      await _tokenStorage.clearTokens();
      handler.next(err);
      for (final queued in _queue) {
        queued.handler.reject(err);
      }
    } finally {
      _isRefreshing = false;
      _queue.clear();
    }
  }
}
