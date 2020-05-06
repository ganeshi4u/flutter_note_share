import 'package:flutter/material.dart';
import 'package:note_share/cache/SharedPreferenceHandler.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferenceHandler _sharedPrefHandler;
  bool _isDarkModeOn = false;

  ThemeProvider() {
    _sharedPrefHandler = SharedPreferenceHandler();
  }

  bool get isDarkModeOn {
    _sharedPrefHandler.isDarkMode.then((value) {
      _isDarkModeOn = value;
    });

    return _isDarkModeOn;
  }

  void updateTheme(bool isDarkModeOn) {
    _sharedPrefHandler.changeTheme(isDarkModeOn);
    _sharedPrefHandler.isDarkMode.then((darkModeStatus) {
      _isDarkModeOn = darkModeStatus;
    });

    notifyListeners();
  }
}
