import 'package:dio/dio.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import '../error/exceptions.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static String getUserFriendlyMessage(dynamic error, AppLocalizations l10n) {
    if (error is DioException) {
      return _handleDioException(error, l10n);
    }
    if (error is ServerException) {
      return _handleServerException(error, l10n);
    }
    return l10n.apiError_unknown;
  }

  static String _handleDioException(DioException error, AppLocalizations l10n) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return l10n.apiError_timeout;
      case DioExceptionType.connectionError:
        return l10n.apiError_noConnection;
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode, error.response?.data, l10n);
      case DioExceptionType.cancel:
        return l10n.apiError_cancelled;
      default:
        return l10n.apiError_network;
    }
  }

  static String _handleStatusCode(int? statusCode, dynamic data, AppLocalizations l10n) {
    final detail = _extractDetail(data);

    switch (statusCode) {
      case 400:
        return detail ?? l10n.apiError_badRequest;
      case 401:
        return l10n.apiError_unauthorized;
      case 403:
        return l10n.apiError_forbidden;
      case 404:
        return l10n.apiError_notFound;
      case 409:
        return detail ?? l10n.apiError_conflict;
      case 413:
        return l10n.apiError_fileTooLarge;
      case 429:
        return l10n.apiError_tooManyRequests;
      case int code when code >= 500:
        return l10n.apiError_server;
      default:
        return detail ?? l10n.apiError_default(statusCode ?? 0);
    }
  }

  static String _handleServerException(ServerException error, AppLocalizations l10n) {
    if (error.statusCode != null) {
      return _handleStatusCode(error.statusCode, null, l10n);
    }
    return error.message;
  }

  static String? _extractDetail(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['detail'] as String? ?? data['message'] as String?;
    }
    return null;
  }
}
