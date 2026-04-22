import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _prefs!.setInt(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs!.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    return await _prefs!.setDouble(key, value);
  }

  static String? getString(String key) {
    return _prefs!.getString(key);
  }

  static int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  static bool? getBool(String key) {
    return _prefs!.getBool(key);
  }

  static double? getDouble(String key) {
    return _prefs!.getDouble(key);
  }

  static Future<bool> remove(String key) async {
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    return await _prefs!.clear();
  }
}