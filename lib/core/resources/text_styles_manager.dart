import 'package:flutter/material.dart';
import 'package:currency_converter/core/resources/app_fonts.dart';

/// A utility class for managing text styles throughout the app.
/// Use the static methods to get standardized [TextStyle]s.
class TextStylesManager {
  const TextStylesManager._(); // Prevent instantiation

  static TextStyle _getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required BuildContext context,
    //String fontFamily = FontFamily.cairo,
  }) {
    return TextStyle(
      fontSize: fontSize,
     // fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      //fontFamily: context.isArabic ? FontFamily.notoSansArabic : FontFamily.montserrat,
      fontFamily: FontFamily.balooBhaijaan,
    );
  }

  /// Regular style
  static TextStyle regular({
    double fontSize = AppFontSize.s12,
    required Color color,
    required BuildContext context,
    //String fontFamily = FontFamily.tajawal,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      fontWeight: AppFontWeight.regular,
      color: color,
      context: context,
     // fontFamily: fontFamily,
    );
  }

  /// Medium style
  static TextStyle medium({
    double fontSize = AppFontSize.s16,
    required Color color,
    required BuildContext context,
   // String fontFamily = FontFamily.tajawal,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      fontWeight: AppFontWeight.medium,
      color: color,
      context: context,
     // fontFamily: fontFamily,
    );
  }

  /// Light style
  static TextStyle light({
    double fontSize = AppFontSize.s12,
    required Color color,
    required BuildContext context,
   // String fontFamily = FontFamily.tajawal,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      fontWeight: AppFontWeight.light,
      context: context,
      color: color,
      //fontFamily: fontFamily,
    );
  }

  /// Bold style
  static TextStyle bold({
    double fontSize = AppFontSize.s12,
    required Color color,
    //String fontFamily = FontFamily.tajawal,
    required BuildContext context,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      fontWeight: AppFontWeight.bold,
      color: color,
      context: context,
     // fontFamily: fontFamily,
    );
  }

  /// SemiBold style
  static TextStyle semiBold({
    double fontSize = AppFontSize.s18,
    required Color color,
   // String fontFamily = FontFamily.tajawal,
    required BuildContext context,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      fontWeight: AppFontWeight.semiBold,
      color: color,
      context: context,
      //fontFamily: fontFamily,
    );
  }
}
