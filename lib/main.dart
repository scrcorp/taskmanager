import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!AppConfig.useMockData) {
    await dotenv.load(fileName: 'assets/.env');
  }
  await HiveConfig.init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
