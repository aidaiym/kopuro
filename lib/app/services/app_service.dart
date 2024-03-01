import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  static const String _kLanguageCodeKey = 'language_code';
  static Future<String?> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLanguageCodeKey);
  }

  static Future<void> saveLanguageCode(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLanguageCodeKey, languageCode);
  }
}
