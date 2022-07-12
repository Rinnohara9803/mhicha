import 'package:flutter/material.dart';
import 'package:mhicha/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var isLanguageEnglish = prefs.getBool('isLanguageEnglish');
    if (isLanguageEnglish == false) {
      _locale = L10n.all[1];
      notifyListeners();
    } else {
      _locale = L10n.all[0];
      notifyListeners();
    }
  }

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
