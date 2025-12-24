import 'package:flutter/material.dart';
import 'package:currency_converter/core/di/service_locator.dart';
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';
class SetLanguageUseCase {

  SetLanguageUseCase();

  Future<void> call(Locale locale) async {
    AppPreferences appPreferences = getIt.get<AppPreferences>();
    await appPreferences.setLanguageCode(locale.languageCode);
  }
}
