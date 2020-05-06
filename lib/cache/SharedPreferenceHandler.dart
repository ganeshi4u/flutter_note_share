import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  Future<SharedPreferences> _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";

  SharedPreferenceHandler() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme
  Future<void> changeTheme(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(is_dark_mode, value);
    });
  }

  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(is_dark_mode) ?? false;
    });
  }
}
