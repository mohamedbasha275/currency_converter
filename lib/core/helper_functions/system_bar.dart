import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/core/resources/app_colors.dart';

/// Utility class for managing system status and navigation bar styles.
class SystemBarHelper {
  /// Sets a light status bar (dark icons) and a white navigation bar.
  static void setLightStatusAndNavBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Make status bar transparent
        statusBarIconBrightness: Brightness.dark,
        // Dark icons for light background
        statusBarBrightness: Brightness.light,
        // For iOS
        systemNavigationBarColor: Colors.white,
        // White nav bar
        systemNavigationBarIconBrightness:
            Brightness.dark, // Dark nav bar icons
      ),
    );
  }

  /// Sets a dark status bar (light icons) and a black navigation bar.
  static void setDarkStatusAndNavBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        // Light icons for dark background
        statusBarBrightness: Brightness.dark,
        // For iOS
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static SystemUiOverlayStyle splashNavBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    // Light icons for dark background
    statusBarBrightness: Brightness.dark,
    // For iOS
    systemNavigationBarColor: AppColors.primary,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static SystemUiOverlayStyle onBoardingNavBar = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    // Light icons for dark background
    statusBarBrightness: Brightness.dark,
    // For iOS
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

/// Example usage in a screen's initState or didChangeDependencies:
///
///   @override
///   void initState() {
///     super.initState();
///     SystemBarHelper.setLightStatusAndNavBar(); // or setDarkStatusAndNavBar()
///   }
///
/// Best practice: Call the appropriate method in each screen's lifecycle
/// (e.g., initState, didChangeDependencies, or in a navigation callback)
/// to ensure the correct system bar style is applied when navigating between screens.
