import 'package:flutter/material.dart';
import 'package:currency_converter/core/animations/app_animations.dart';
import 'package:currency_converter/core/di/service_locator.dart';
/// Centralized route names for the app.
/// Add new route names here as your app grows.
class AppRoutes {
  static const String home = '/home';
}

/// Handles route generation for the app.
/// Use [AppRouteGenerator.generateRoute] in your MaterialApp's onGenerateRoute.
class AppRouteGenerator {
  const AppRouteGenerator._(); // Prevent instantiation

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return pageRoute(
          page: const Text('data'),
          //settings: settings,
        );
      default:
        return _undefinedRoute(settings.name);
    }
  }

  static Route<dynamic> _undefinedRoute(String? routeName) {
    return pageRoute(
      page: Scaffold(
        appBar: AppBar(title: Text('route_not_found')),
        body: Center(
          child: Text(
            'No route defined for "$routeName"',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
