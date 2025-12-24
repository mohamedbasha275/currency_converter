import 'dart:ui';

/// Supported language types for the app.
enum LanguageType { english, arabic }

/// Language codes
class LanguageCodes {
  static const String arabic = 'ar';
  static const String english = 'en';
}

/// Localization asset path
const String kLocalizationAssetPath = 'assets/translations';

/// Supported locales
class AppLocales {
  static const Locale arabic = Locale('ar', 'SA');
  static const Locale english = Locale('en', 'US');
}

/// Extension for [LanguageType] to get language code and locale.
extension LanguageTypeExtension on LanguageType {
  /// Returns the language code for the [LanguageType].
  String get code {
    switch (this) {
      case LanguageType.english:
        return LanguageCodes.english;
      case LanguageType.arabic:
        return LanguageCodes.arabic;
    }
  }

  /// Returns the [Locale] for the [LanguageType].
  Locale get locale {
    switch (this) {
      case LanguageType.english:
        return AppLocales.english;
      case LanguageType.arabic:
        return AppLocales.arabic;
    }
  }
}
