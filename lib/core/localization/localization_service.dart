import 'package:flutter/material.dart';

class LocalizationService {
  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const path = 'assets/translations';

  static const fallbackLocale = Locale('en');
  static const startLocale = Locale('ar');
}