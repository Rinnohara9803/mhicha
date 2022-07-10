import 'package:flutter/material.dart';
import 'package:mhicha/services/shared_services.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = SharedService.isDarkMode;

  bool get isDarkMode {
    return _isDarkMode;
  }

  void changeTheme(bool isDarkMode) {
    if (isDarkMode == false) {
      SharedService.isDarkMode = true;
      _isDarkMode = true;
      notifyListeners();
    } else {
      SharedService.isDarkMode = false;
      _isDarkMode = false;
      notifyListeners();
    }
  }
}
