import 'package:flutter/material.dart';
import 'package:mhicha/services/shared_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = SharedService.isDarkMode;

  bool get isDarkMode {
    return _isDarkMode;
  }

  Future<void> changeTheme() async {
    if (SharedService.isDarkMode == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isDarkMode', true);
      SharedService.isDarkMode = prefs.getBool('isDarkMode') as bool;
      _isDarkMode = SharedService.isDarkMode;
      notifyListeners();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isDarkMode', false);
      SharedService.isDarkMode = prefs.getBool('isDarkMode') as bool;
      _isDarkMode = SharedService.isDarkMode;
      notifyListeners();
    }
  }

  Future<void> getIsDarkModeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isDarkMode = prefs.getBool('isDarkMode');

    if (isDarkMode == false) {
      SharedService.isDarkMode = false;
    } else {
      SharedService.isDarkMode = true;
      _isDarkMode = SharedService.isDarkMode;
      notifyListeners();
    }
  }
}
