import 'package:currency_converter/common/animations/app_animations.dart';
import 'package:currency_converter/core/navigation/app_routers.dart';
import 'package:currency_converter/features/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouteGenerator {
  const AppRouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return pageRoute(
          page: const HomeScreen(),
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