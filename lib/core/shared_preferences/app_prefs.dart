import 'package:shared_preferences/shared_preferences.dart';

class AppPrefsKeys {
  static const String onBoardingScreenViewed = 'onBoardingScreenViewed';
}

class AppPreferences {
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  Future<void> setOnBoardingScreenViewed({bool viewed = true}) async {
    await _prefs.setBool(AppPrefsKeys.onBoardingScreenViewed, viewed);
  }

  bool isOnBoardingScreenViewed() {
    return _prefs.getBool(AppPrefsKeys.onBoardingScreenViewed) ?? false;
  }
}
