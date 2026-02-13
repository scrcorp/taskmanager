class AppConstants {
  AppConstants._();

  static const String appName = 'TaskManager';
  static const String tokenBoxName = 'auth_tokens';
  static const String cacheBoxName = 'api_cache';

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;

  // Cache TTL (in minutes)
  static const int defaultCacheTtl = 5;
  static const int shortCacheTtl = 1;
  static const int longCacheTtl = 30;
}
