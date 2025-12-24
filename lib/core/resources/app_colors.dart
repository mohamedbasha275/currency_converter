import 'package:flutter/material.dart';

/// Centralized color palette for the app.
/// Use these colors throughout the app for consistency and easy maintenance.
class AppColors {
  // Primary colors
  static const MaterialColor primarySwatch = Colors.blue;
  static Color primary = fromHex('4B5DE0');
  static Color primarySplash = fromHex('475EE8');
  static Color primaryDark = fromHex('3846A8');
  static Color primaryLight = fromHex('EEF0FC');
  static Color primaryLight2 = fromHex('E5E8FB');
  static Color selectionColor = fromHex('a2a2f5');
  //
  static Color pofileIconColor = fromHex('A7A9B9');
  //
  static Color male = fromHex('335DB9');
  static Color maleLight = fromHex('D9E5FF');
  static Color female = fromHex('CD13AE');
  static Color femaleLight = fromHex('F8B2EC');
//
  static Color onBoardingProgress = fromHex('D9D9D9');

  // Background colors
  static Color background = fromHex('F1F1F1');
  static Color backgroundGrey = fromHex('F5F6F9');

  // Label colors
  static Color label1Color = fromHex('F8F8F8');
  static Color label2Color = fromHex('B4B4B4');
  static Color label3Color = fromHex('2B2B2B');
  static Color nearWhite = fromHex('EBEBEB');

  // Grey colors
  static Color greyTextColor = fromHex('737373');
  static Color greyLightColor = fromHex('B3B3B3');
  static Color grey2Color = fromHex('C2C2C2');
  static Color nearGreyColor = fromHex('838383');
  static Color nearGrey2Color = fromHex('D8DADC');
  
  // Border colors
  static Color borderColor = fromHex('CFCFCF');
  static Color border2Color = fromHex('C8C8C8');

  //
  static Color darkColor = fromHex('1A214E');
  static Color darkBorderColor = fromHex('4B5DE0');
  static Color darkPrimary = fromHex('2D3886');
  static Color greySelect = fromHex('505053');

  // Indicator colors
  static Color disabledIndicator = fromHex('D6D6D6');
  
  // Notification colors
  static Color notfDelete = fromHex('FEE5E5');
  static Color notfIcon = fromHex('FF2E2E');
  static Color notfUnRead = fromHex('EFFDF4');
  static Color notfReadDivider = fromHex('D6D6D6');
  static Color notfUnReadDivider = fromHex('B6EFCD');
  
  // Success and active colors
  static Color successColor = fromHex('16B857');
  static Color activeColor = fromHex('15cc5e');
  static Color activeLightColor = fromHex('EAFCF1');
  static Color activeText = fromHex('11A34B');
  static Color active2Text = fromHex('074721');
  static Color activeLight = fromHex('F3FCF6');

  // Inactive colors
  static Color deActiveColor = fromHex('414141');
  static Color deActiveBarColor = fromHex('6B6B6B');


  // formFieldBorderColor
  static Color formFieldBorderColor = fromHex('999999');
  static Color selectCountryColor = fromHex('3B3B3B');

  // Black text colors
  static Color nearBlackTextColor = fromHex('101010');
  static Color nearBlack2TextColor = fromHex('393939');
  static Color nearBlack3TextColor = fromHex('626262');
  static Color nearBlack4TextColor = fromHex('202020');
  static Color nearBlack5TextColor = fromHex('292929');
  static Color black2Color = fromHex('021409');
  static Color black3Color = fromHex('141414');
  static Color black4Color = fromHex('313131');


  static Color nearGrey3Color = fromHex('979696');

  // Store badge colors
  static Color newStore = fromHex('2FEAF1');
  static Color exclusiveStore = fromHex('FF8DBE');
  
  // Offer colors
  static Color offerBorder = fromHex('E3E3E3');
  static Color pinBorder = fromHex('ADADAD');
  static Color offerBorderText = fromHex('7B7B7B');
  static Color offerTimeText = fromHex('929292');
  static Color offerDesText = fromHex('4A4A4A');
  
  // Other colors
  static Color couponBackColor = fromHex('F2F3F7');
  static Color shadow = fromHex('121217');
  static Color shadow2 = fromHex('121217').withValues(alpha: 0.05);
  static Color shadow3 = fromHex('121217').withValues(alpha: 0.10);
  static Color shadow4 = fromHex('121217').withValues(alpha: 0.06);
  static Color smallBoxColor = fromHex('EFFDF4');
  //
  static Color errorCheckColor = fromHex('FF2E2E');
  static Color successCheckColor = fromHex('15CC5E');

  // Theme colors (used in ThemeManager and other core components)
  static const Color splash = Colors.lightGreen;
  static const Color reset = Colors.redAccent;
  static const Color failure = Colors.red;
  static const Color success = Colors.green;
  static const Color cancel = Colors.lightBlue;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static Color disabled = fromHex('B9BCBE');
  static const Color transparent = Colors.transparent;
}

/// Utility: Convert hex string (e.g. "#FF00FF") to [Color].
Color fromHex(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  hex = hex.replaceFirst('#', '');
  buffer.write(hex);
  return Color(int.parse(buffer.toString(), radix: 16));
}