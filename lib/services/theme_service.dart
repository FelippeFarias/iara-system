import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../utils/constants.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isThemeMode';
  static const DARK_MODE = 'dark_mode';
  static const LIGHT_MODE = 'light_mode';
  static const SYSTEM_MODE = 'system_mode';

  ThemeMode get theme {
    switch(_loadThemeFromBox()){
      case DARK_MODE: return ThemeMode.dark;
      case LIGHT_MODE: return ThemeMode.light;
      case SYSTEM_MODE: return ThemeMode.light;
      default : return ThemeMode.light;
    }

  }

  String _loadThemeFromBox() {
    return  _box.read(_key) ?? 'light_mode';
  }

  _saveThemeToBox(String themeMode) => _box.write(_key, themeMode);

  Future<void> switchTheme(String themeMode) async {
    _saveThemeToBox(themeMode);
    Get.changeThemeMode(theme);

  }
}