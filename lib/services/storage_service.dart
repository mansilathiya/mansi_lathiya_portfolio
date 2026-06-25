import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class AppStorageKeys {
  static const String theme = "pref_is_dark_theme";
}

class StorageService extends GetxService {
  late final SharedPreferences _prefs;

  static Future<StorageService> init() async {
    final instance = StorageService();
    instance._prefs = await SharedPreferences.getInstance();
    return instance;
  }

  // Read
  bool getTheme(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  // Write
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  // // ── Utility
  // bool           hasKey(String key) => _prefs.containsKey(key);
  // Future<bool>   remove(String key) => _prefs.remove(key);
  // Future<bool>   clear()            => _prefs.clear();
}
