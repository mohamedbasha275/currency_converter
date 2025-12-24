import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/text_styles_manager.dart';
import 'package:currency_converter/core/resources/values_manager.dart';

class ThemeManager {
  ThemeManager._();

  //static final ThemeData light = _buildLightTheme();
  static ThemeData light(BuildContext context) => _buildLightTheme(context);

  static ThemeData _buildLightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.couponBackColor,
      canvasColor: AppColors.couponBackColor,

      primarySwatch: AppColors.primarySwatch,
      primaryColor: AppColors.primary,
      appBarTheme: _appBarTheme(),
      buttonTheme: _buttonTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(context),
      textTheme: _textTheme(context),
      inputDecorationTheme: _inputDecorationTheme(context),
      //
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,        // لون الكيرسر
        selectionColor: AppColors.selectionColor, // لون التحديد (Highlight)
        selectionHandleColor: AppColors.primary, // لون الدائرة اللي بتسحبها
      ),
    );
  }

  static AppBarTheme _appBarTheme() {
    return AppBarTheme(
      elevation: AppSize.zero,
      surfaceTintColor: AppColors.couponBackColor,
      backgroundColor: AppColors.couponBackColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.couponBackColor,
        // statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark, // Android
        statusBarBrightness: Brightness.dark, // iOS
        //
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.transparent,
      ),
    );
  }

  static ButtonThemeData _buttonTheme() {
    return ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: AppColors.disabled,
      buttonColor: AppColors.primary,
      splashColor: AppColors.splash,
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(BuildContext context) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStylesManager.light(
          color: AppColors.primary,
          fontSize: 22,
          context: context,
        ),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        disabledBackgroundColor: AppColors.disabled,
      ),
    );
  }

  static TextTheme _textTheme(BuildContext context) {
    return TextTheme(
      headlineLarge: TextStylesManager.bold(color: AppColors.white, fontSize: 30, context: context),
      headlineSmall: TextStylesManager.bold(color: AppColors.white, fontSize: 16, context: context),
      displaySmall: TextStylesManager.medium(color: AppColors.white, fontSize: 16, context: context),
      labelMedium: TextStylesManager.medium(color: AppColors.white, fontSize: 18, context: context),
      displayLarge: TextStylesManager.regular(color: AppColors.black, fontSize: 30, context: context),
      bodyMedium: TextStylesManager.regular(
        color: AppColors.grey,
        fontSize: 16,
        context: context,
      ),
      titleMedium: TextStylesManager.regular(color: AppColors.black, fontSize: 16, context: context),
      labelSmall: TextStylesManager.regular(
        color: AppColors.primary,
        fontSize: 12,
        context: context,
      ),
      labelLarge: TextStylesManager.bold(
        color: AppColors.primary,
        fontSize: 24,
        context: context,
      ),
      displayMedium: TextStylesManager.medium(color: AppColors.black, fontSize: 18, context: context),
      titleSmall: TextStylesManager.medium(color: AppColors.black, fontSize: 16, context: context),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(BuildContext context) {
    return InputDecorationTheme(
      prefixIconColor: AppColors.cancel,
      contentPadding: const EdgeInsets.all(8),
      hintStyle: TextStylesManager.regular(color: AppColors.grey, fontSize: 14, context: context),
      labelStyle: TextStylesManager.medium(color: AppColors.grey, fontSize: 14, context: context),
      errorStyle: TextStylesManager.regular(color: AppColors.reset, fontSize: 14, context: context),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.reset, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
