import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const MaterialColor primarySwatch = Colors.blue;
  static Color primary = fromHex('2563EB');
  static Color primary2 = fromHex('2F6BFF');
  static Color convertCard = fromHex('F3F6FA');
  static Color cardBorder = fromHex('E3E9F3');
  static Color background = Colors.white;
  static Color iconColor = Colors.white;
  static Color shadow = Colors.black26;
  static Color nearBlueGrey =fromHex('7C8AA5');
  static Color mainTextColor =fromHex('0B1220');
  static Color secondTextColor = Colors.white;
  static Color dropDownIcon = fromHex('7C8AA5');
  static Color activeBadge = fromHex('12B76A');
  static Color dashedChart = fromHex('E9EEF1');
  static Color upRate = fromHex('12B76A');
  static Color downRate = fromHex('FF3B30');
  static Color upRateBg = fromHex('E6FFF3');
  static Color downRateBg = fromHex('FFEBEE');
  static Color activeOnboarding = fromHex('ffbf00');
  // Gradient colors onboarding based on primary color
  static Color gradientWhite  = primary.withValues(alpha: 0.05);
  static Color gradientLight  = primary.withValues(alpha: 0.26);
  static Color gradientMedium = primary.withValues(alpha: 0.72);
  static Color gradientDark   = primary.withValues(alpha: 0.89);
}

Color fromHex(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  hex = hex.replaceFirst('#', '');
  buffer.write(hex);
  return Color(int.parse(buffer.toString(), radix: 16));
}
