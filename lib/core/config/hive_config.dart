import 'package:hive_flutter/hive_flutter.dart';
import '../storage/cache_storage.dart';

class HiveConfig {
  static final CacheStorage cacheStorage = CacheStorage();

  static Future<void> init() async {
    await Hive.initFlutter();
    await cacheStorage.init();
    await Hive.openBox('settings');
  }
}
