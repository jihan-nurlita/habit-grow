import 'package:flutter/material.dart';
import 'package:habit_grow/core/theme/theme_data.dart';
import 'package:habit_grow/core/theme/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  /// COLOR THEME
  ThemeModel _selectedTheme = greenTheme;

  ThemeModel get selectedTheme => _selectedTheme;

  /// MODE
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  /// =========================
  /// CURRENT THEME
  /// =========================
  ThemeModel get currentTheme {
    if (_isDarkMode) {
      return ThemeModel(
        primaryColor: _selectedTheme.primaryColor,
        backgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        iconColor: Colors
            .white, // atau bisa pakai _selectedTheme.primaryColor agar ikon menyesuaikan tema
        textColor: Colors.white,
        softColor: const Color(
            0xFF2A2A2A), // Ubah jadi abu-abu gelap netral, jangan pakai primaryColor.withOpacity!
        borderColor: const Color(0xFF2C2C2C),
      );
    }

    return _selectedTheme;
  }

  /// =========================
  /// CHANGE COLOR
  /// =========================
  void changeTheme(ThemeModel theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  /// =========================
  /// DARK MODE
  /// =========================
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
