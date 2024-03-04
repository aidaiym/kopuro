import 'package:flutter/material.dart';

class AppConst {
  const AppConst._();
  static String get localeKey => _localeKey;
  static const _localeKey = 'locale';
  static const locales = <Locale>[
    Locale('en'),
    Locale('ky'),
    Locale('ru'),
  ];

  static String getName(String code) {
    return switch (code) {
      'en' => 'English',
      'ky' => 'Кыргызча',
      'ru' => 'Русский',
      _ => 'English',
    };
  }

  static bool isLocalSupport(String deviceLocal) {
    return switch (deviceLocal) {
      'en' || 'ky' || 'ru' => true,
      _ => false,
    };
  }
}
