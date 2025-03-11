import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void _checkInitialization() {
    assert(_sharedPreferences != null, 'SharedPreferences not initialized. Call LocalStorageData.init() first.');
  }

  static Future<bool> setBool(String key, bool value) async {
    _checkInitialization();
    return _sharedPreferences!.setBool(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    _checkInitialization();
    return _sharedPreferences!.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    _checkInitialization();
    return _sharedPreferences!.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    _checkInitialization();
    return _sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> setList(String key, List<String> value) async {
    _checkInitialization();
    return _sharedPreferences!.setStringList(key, value);
  }

  static bool getBool(String key) {
    _checkInitialization();
    return _sharedPreferences!.getBool(key) ?? false;
  }

  static String getString(String key) {
    _checkInitialization();
    return _sharedPreferences!.getString(key) ?? '';
  }

  static int getInt(String key) {
    _checkInitialization();
    return _sharedPreferences!.getInt(key) ?? 0;
  }

  static double getDouble(String key) {
    _checkInitialization();
    return _sharedPreferences!.getDouble(key) ?? 0.0;
  }

  static List<String> getList(String key) {
    _checkInitialization();
    return _sharedPreferences!.getStringList(key) ?? [];
  }

  static Future<bool> remove(String key) async {
    _checkInitialization();
    return _sharedPreferences!.remove(key);
  }

  static Future<bool> clear() async {
    _checkInitialization();
    return _sharedPreferences!.clear();
  }
}