import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/core/localization/get_language_use_case.dart';
import 'package:currency_converter/core/localization/localization_service.dart';
import 'package:currency_converter/core/localization/set_language_use_case.dart';

class LanguageCubit extends Cubit<Locale> {
  final SetLanguageUseCase setLanguageUseCase;
  final GetLanguageUseCase getLanguageUseCase;

  static const _fallbackLocale = LocalizationService.startLocale;

  LanguageCubit({
    required this.getLanguageUseCase,
    required this.setLanguageUseCase,
  }) : super(_fallbackLocale) {
    _loadLanguage();
  }

  void setLanguage(Locale locale) async {
    await setLanguageUseCase.call(locale);
    emit(locale);
  }

  void _loadLanguage() async {
    try {
      final languageCode = await getLanguageUseCase.call();
      if (languageCode.isNotEmpty) {
        emit(Locale(languageCode));
      } else {
        emit(_fallbackLocale);
      }
    } catch (e) {
      emit(_fallbackLocale);
    }
  }
}
