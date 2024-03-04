import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class AppService {
  const AppService();

  Future<Locale> getInitLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(AppConst.localeKey);
    if (code != null) {
      return Locale(code);
    }
    // ignore: deprecated_member_use
    final deviceLocale = window.locale.languageCode;
    return AppLocalizations.delegate.isSupported(Locale(deviceLocale))
        ? Locale(deviceLocale)
        : const Locale('en');
  }

  Future<Locale> setLocale(String langKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConst.localeKey, langKey);
    return Locale(langKey);
  }
}
