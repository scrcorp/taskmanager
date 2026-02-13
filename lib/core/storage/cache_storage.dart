import 'dart:convert';
import 'package:hive/hive.dart';
import '../constants/app_constants.dart';

class CacheStorage {
  Box? _box;

  Future<void> init() async {
    _box = await Hive.openBox(AppConstants.cacheBoxName);
  }

  Future<void> put(String key, dynamic data, {int? ttlMinutes}) async {
    final entry = {
      'data': jsonEncode(data),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'ttl': ttlMinutes ?? AppConstants.defaultCacheTtl,
    };
    await _box?.put(key, entry);
  }

  dynamic get(String key) {
    final entry = _box?.get(key);
    if (entry == null) return null;

    final map = Map<String, dynamic>.from(entry);
    final timestamp = map['timestamp'] as int;
    final ttl = map['ttl'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now - timestamp > ttl * 60 * 1000) {
      _box?.delete(key);
      return null;
    }

    return jsonDecode(map['data'] as String);
  }

  Future<void> invalidate(String key) async {
    await _box?.delete(key);
  }

  Future<void> invalidatePattern(String pattern) async {
    final keys = _box?.keys.where((k) => k.toString().contains(pattern)).toList() ?? [];
    for (final key in keys) {
      await _box?.delete(key);
    }
  }

  Future<void> clear() async {
    await _box?.clear();
  }
}
