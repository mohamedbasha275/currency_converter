import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SystemBarHelper {
  static PreferredSize onBoardingTopBar = PreferredSize(
    preferredSize: const Size.fromHeight(0),
    child: AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.gradientDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      automaticallyImplyLeading: false,
    ),
  );
}
