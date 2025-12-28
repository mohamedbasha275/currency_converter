import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_converter/core/resources/app_colors.dart';

class ThemeManager {
  ThemeManager._();

  static ThemeData light(BuildContext context) => _buildLightTheme(context);

  static ThemeData _buildLightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      primarySwatch: AppColors.primarySwatch,
      primaryColor: AppColors.primary,
      appBarTheme: _appBarTheme(),
      buttonTheme: _buttonTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(),
      textTheme: _textTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.iconColor,
        selectionHandleColor: AppColors.primary,
      ),
    );
  }

  static AppBarTheme _appBarTheme() {
    return AppBarTheme(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor:AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      elevation: 0,
    );
  }

  static ButtonThemeData _buttonTheme() {
    return ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: AppColors.iconColor,
      buttonColor: AppColors.primary,
      splashColor: AppColors.iconColor,
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles.highlightWhiteMed,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 10),
        disabledBackgroundColor: AppColors.mainTextColor,
      ),
    );
  }

  static TextTheme _textTheme() {
    return TextTheme(
      headlineLarge: AppTextStyles.displayBlackBold,
      headlineMedium: AppTextStyles.highlightBlackBold,
      headlineSmall: AppTextStyles.headingMain,
      bodyLarge: AppTextStyles.bodyMedBlueGrey,
      bodyMedium: AppTextStyles.bodyBoldBlueGrey,
      bodySmall: AppTextStyles.bodyMedBlueGrey,
      labelLarge: AppTextStyles.captionBlueGreyReg,
      labelMedium: AppTextStyles.captionBlueGreyMed,
      labelSmall: AppTextStyles.captionBlueGreyMed,
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      prefixIconColor: AppColors.iconColor,
      contentPadding: const EdgeInsets.all(8),
      hintStyle:AppTextStyles.subtitleNearBlueGreySemi,
      labelStyle: AppTextStyles.subtitleNearBlueGreySemi,
      errorStyle:AppTextStyles.subtitleNearBlueGreySemi,
      enabledBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.iconColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.iconColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
