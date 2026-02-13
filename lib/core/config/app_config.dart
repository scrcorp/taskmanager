import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, prod }

class AppConfig {
  /// Set to true to use mock data instead of API calls.
  /// Toggle this to false when the backend is available.
  static const bool useMockData = true;

  static Environment get environment {
    final env = dotenv.get('ENV', fallback: 'dev');
    return env == 'prod' ? Environment.prod : Environment.dev;
  }

  static String get baseUrl => dotenv.get('BASE_URL');

  static Duration get connectTimeout => const Duration(seconds: 15);
  static Duration get receiveTimeout => const Duration(seconds: 30);
  static int get maxRetries => 3;
  static Duration get cacheTtl => const Duration(minutes: 5);
}
