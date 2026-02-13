import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  static const _boxName = 'settings';
  static const _key = 'locale_code';
  static const defaultLocale = Locale('en');
  static const supportedLocales = [
    Locale('en'),
    Locale('ko'),
    Locale('es'),
  ];

  LocaleNotifier() : super(defaultLocale) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final box = await Hive.openBox(_boxName);
    final code = box.get(_key, defaultValue: null);
    if (code != null && supportedLocales.any((l) => l.languageCode == code)) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    state = locale;
    final box = await Hive.openBox(_boxName);
    await box.put(_key, locale.languageCode);
  }
}
