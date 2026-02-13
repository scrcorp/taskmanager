import 'package:dio/dio.dart';
import '../storage/cache_storage.dart';

class CacheInterceptor extends Interceptor {
  final CacheStorage _cacheStorage;

  CacheInterceptor({required CacheStorage cacheStorage})
      : _cacheStorage = cacheStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method != 'GET') {
      return handler.next(options);
    }

    final forceRefresh = options.extra['forceRefresh'] == true;
    if (forceRefresh) {
      return handler.next(options);
    }

    final cacheKey = _buildCacheKey(options);
    final cachedData = _cacheStorage.get(cacheKey);

    if (cachedData != null) {
      return handler.resolve(
        Response(
          requestOptions: options,
          data: cachedData,
          statusCode: 200,
          statusMessage: 'OK (cached)',
        ),
        true,
      );
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == 'GET' &&
        response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final cacheKey = _buildCacheKey(response.requestOptions);
      final ttl = _getTtlForPath(response.requestOptions.path);
      if (ttl > 0) {
        _cacheStorage.put(cacheKey, response.data, ttlMinutes: ttl);
      }
    }
    return handler.next(response);
  }

  String _buildCacheKey(RequestOptions options) {
    final queryHash = options.queryParameters.isNotEmpty
        ? '_${options.queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&').hashCode}'
        : '';
    return '${options.method}_${options.path}$queryHash';
  }

  int _getTtlForPath(String path) {
    if (path.contains('/auth/me')) return 1;
    if (path.contains('/dashboard/summary')) return 2;
    if (path.contains('/attendance/today')) return 1;
    if (path.contains('/attendance/history')) return 1;
    if (path.contains('/notifications')) return 1;
    if (path.contains('/assignments')) return 5;
    if (path.contains('/notices')) return 5;
    if (path.contains('/daily-checklists')) return 5;
    return 0;
  }
}
