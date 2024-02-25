import 'package:flutter/material.dart';
import 'package:hydraware/pages/settings_screens/theme/dark_theme.dart';
import 'package:hydraware/pages/settings_screens/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme = lightTheme;

  ThemeData get getTheme => _selectedTheme;

  void setTheme(ThemeData theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_selectedTheme == lightTheme) {
      _selectedTheme = darkTheme;
    } else {
      _selectedTheme = lightTheme;
    }
    notifyListeners();
  }
}
