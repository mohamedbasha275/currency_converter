import 'package:shared_preferences/shared_preferences.dart';

/// Keys used for storing preferences in [SharedPreferences].
class AppPrefsKeys {
  static const String isUserLogged = 'isUserLoggedKey';
  static const String isUserGuest = 'isUserGuestKey';
  static const String isGuestFresh = 'isGuestFresh';
  static const String authToken = 'authTokenKey';
  static const String darkMode = 'darkMode'; // Fixed key name for clarity
  static const String savedStore = 'savedStore';
  static const String onBoardingScreenViewed = 'onBoardingScreenViewed';
  static const String userName = 'userNameKey';
   static const String userEmail = 'userEmail';
  static const String languageCode = 'languageCode';
  static const String appCurrency = 'appCurrency';
  static const String userLocation = 'userLocation';
  static const String selectedCountry = 'selectedCountry';
  static const String selectedCountryId = 'selectedCountryId';
  static const String selectedLanguageId = 'selectedLanguageId';
  static const String cachedCountries = 'cachedCountries';
  static const String countriesCacheTimestamp = 'countriesCacheTimestamp';
}

/// A wrapper for [SharedPreferences] to manage app-specific preferences.
class AppPreferences {
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  // region: Login

  Future<void> setIsLogged({bool value = true}) async {
    await _prefs.setBool(AppPrefsKeys.isUserLogged, value);
  }

  bool isLogged() {
    return _prefs.getBool(AppPrefsKeys.isUserLogged) ?? false;
  }


  Future<void> setIsGuest({bool value = true}) async {
    await _prefs.setBool(AppPrefsKeys.isUserGuest, value);
  }

  bool isUserGuest() {
    return _prefs.getBool(AppPrefsKeys.isUserGuest) ?? true;
  }

  // setIsGuestFresh
  Future<void> setIsGuestFresh({bool value = true}) async {
    await _prefs.setBool(AppPrefsKeys.isGuestFresh, value);
  }

  bool isGuestFresh() {
    return _prefs.getBool(AppPrefsKeys.isGuestFresh) ?? true;
  }


  // endregion

  // region: Logout

  Future<void> logout() async {
    // Remove all user-related keys
    final keysToRemove = [
      //AppPrefsKeys.isUserLogged,
      AppPrefsKeys.isUserGuest,
     // AppPrefsKeys.authToken,
      AppPrefsKeys.userName,
      AppPrefsKeys.savedStore,
      AppPrefsKeys.appCurrency,
      AppPrefsKeys.userLocation,
      AppPrefsKeys.userEmail,
    ];
    await setIsGuestFresh(value: false);
    await Future.wait(keysToRemove.map(_prefs.remove));
  }

  // endregion

  // region: Auth Token

  Future<void> setAuthToken(String token) async {
    await _prefs.setString(AppPrefsKeys.authToken, token);
  }

  String getAuthToken() {
    return _prefs.getString(AppPrefsKeys.authToken) ?? '';
  }

  // endregion

  // region: User Name

  Future<void> setUserName(String name) async {
    await _prefs.setString(AppPrefsKeys.userName, name);
  }

  String getUserName() {
    return _prefs.getString(AppPrefsKeys.userName) ?? '';
  }
  // region: User Email

  Future<void> setUserEmail(String email) async {
    await _prefs.setString(AppPrefsKeys.userEmail, email);
  }

  String getUserEmail() {
    return _prefs.getString(AppPrefsKeys.userEmail) ?? '';
  }
  // endregion

  // region: Dark Mode

  Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool(AppPrefsKeys.darkMode, isDark);
  }

  bool isDarkMode() {
    return _prefs.getBool(AppPrefsKeys.darkMode) ?? false;
  }

  // endregion

  // region: Store Data

  Future<void> saveStoreData({
    required String storeId,
    required String storeName,
  }) async {
    await _prefs.setStringList(AppPrefsKeys.savedStore, [storeId, storeName]);
  }

  /// Returns [storeId, storeName] or ['0', ''] if not set.
  List<String> getStoreData() {
    final store = _prefs.getStringList(AppPrefsKeys.savedStore);
    if (store != null && store.length == 2) {
      return store;
    }
    return ['0', ''];
  }

  // endregion

  // region: OnBoarding

  Future<void> setOnBoardingScreenViewed({bool viewed = true}) async {
    await _prefs.setBool(AppPrefsKeys.onBoardingScreenViewed, viewed);
  }

  bool isOnBoardingScreenViewed() {
    return _prefs.getBool(AppPrefsKeys.onBoardingScreenViewed) ?? false;
  }

  // endregion

  // region: Language

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString(AppPrefsKeys.languageCode, code);
  }

  String getLanguageCode({String fallback = 'ar'}) {
    return _prefs.getString(AppPrefsKeys.languageCode) ?? fallback;
  }

  // endregion

  // region: Currency

  Future<void> setAppCurrency(String currency) async {
    await _prefs.setString(AppPrefsKeys.appCurrency, currency);
  }

  String getAppCurrency({String fallback = 'د.أ'}) {
    return _prefs.getString(AppPrefsKeys.appCurrency) ?? fallback;
  }

  // endregion

  // region: User Location

  /// Stores user location as [lat, long, locationName].
  Future<void> setUserLocation({
    required double lat,
    required double long,
    required String location,
  }) async {
    await _prefs.setStringList(
      AppPrefsKeys.userLocation,
      [lat.toString(), long.toString(), location],
    );
  }

  /// Returns [lat, long, locationName] as strings, or empty list if not set.
  List<String> getUserLocation() {
    return _prefs.getStringList(AppPrefsKeys.userLocation) ?? [];
  }

  // endregion

  // region: Selected Country

  /// Stores selected country as [code, name, currency, currency_symbol].
  Future<void> setSelectedCountry({
    required String code,
    required String name,
    required String currency,
    required String currencySymbol,
    required String countryFlag,
  }) async {
    await _prefs.setStringList(
      AppPrefsKeys.selectedCountry,
      [code, name, currency, currencySymbol,countryFlag],
    );
  }

  /// Returns [code, name, currency, currency_symbol] or empty list if not set.
  List<String> getSelectedCountry() {
    return _prefs.getStringList(AppPrefsKeys.selectedCountry) ?? [];
  }

  /// Saves the selected country ID
  Future<void> setSelectedCountryId(int countryId) async {
    await _prefs.setInt(AppPrefsKeys.selectedCountryId, countryId);
  }

  /// Gets the selected country ID, returns 0 if not set
  int getSelectedCountryId() {
    return _prefs.getInt(AppPrefsKeys.selectedCountryId) ?? 0;
  }

  /// Saves the selected language ID
  Future<void> setSelectedLanguageId(int languageId) async {
    await _prefs.setInt(AppPrefsKeys.selectedLanguageId, languageId);
  }

  /// Gets the selected language ID, returns 0 if not set
  int getSelectedLanguageId() {
    return _prefs.getInt(AppPrefsKeys.selectedLanguageId) ?? 0;
  }

  // endregion

  // region: Countries Cache

  /// Caches countries data with current timestamp
  Future<void> cacheCountries(List<Map<String, dynamic>> countries) async {
    // Convert countries to JSON strings
    final countriesJson = countries.map((country) => {
      'code': country['code'],
      'name': country['name'],
      'currency': country['currency'],
      'currencySymbol': country['currencySymbol'],
    }).toList();
    
    await _prefs.setStringList(
      AppPrefsKeys.cachedCountries,
      countriesJson.map((country) => 
        '${country['code']}|${country['name']}|${country['currency']}|${country['currencySymbol']}'
      ).toList(),
    );
    
    // Save current timestamp
    await _prefs.setInt(AppPrefsKeys.countriesCacheTimestamp, DateTime.now().millisecondsSinceEpoch);
  }

  /// Gets cached countries if cache is still valid (less than 24 hours old)
  List<Map<String, dynamic>>? getCachedCountries() {
    final timestamp = _prefs.getInt(AppPrefsKeys.countriesCacheTimestamp);
    if (timestamp == null) return null;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    
    // Check if cache is older than 24 hours
    if (now.difference(cacheTime).inHours >= 24) {
      return null;
    }
    
    final cachedData = _prefs.getStringList(AppPrefsKeys.cachedCountries);
    if (cachedData == null || cachedData.isEmpty) return null;
    
    // Convert back to list of maps
    return cachedData.map((item) {
      final parts = item.split('|');
      return {
        'code': parts[0],
        'name': parts[1],
        'currency': parts[2],
        'currencySymbol': parts[3],
      };
    }).toList();
  }

  /// Checks if countries cache exists and is valid
  bool isCountriesCacheValid() {
    final timestamp = _prefs.getInt(AppPrefsKeys.countriesCacheTimestamp);
    if (timestamp == null) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    
    // Cache is valid if it's less than 24 hours old
    return now.difference(cacheTime).inHours < 24;
  }

  /// Clears countries cache
  Future<void> clearCountriesCache() async {
    await _prefs.remove(AppPrefsKeys.cachedCountries);
    await _prefs.remove(AppPrefsKeys.countriesCacheTimestamp);
  }

  // endregion

  // region: Generic Methods for InAppReviewService

  /// Generic method to get boolean value
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  /// Generic method to set boolean value
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  /// Generic method to get integer value
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  /// Generic method to set integer value
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  /// Generic method to remove a key
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // endregion
}
