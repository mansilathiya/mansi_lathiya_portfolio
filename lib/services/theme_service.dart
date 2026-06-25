import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mansi_lathiya_portfolio/services/storage_service.dart';

class ThemeService extends GetxService {
  ThemeService(this._storage);

  final StorageService _storage;

  /// The last user-selected theme, restored from local storage.
  /// Defaults to dark mode when no preference has been saved yet.
  bool get isDark =>
      _storage.getTheme(AppStorageKeys.theme, defaultValue: true);

  /// Persists [value] to local storage and instantly switches the app theme.
  Future<void> saveTheme(bool value) async {
    await _storage.setBool(AppStorageKeys.theme, value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
