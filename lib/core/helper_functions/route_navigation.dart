import 'package:flutter/material.dart';

/// Navigates to the given [route] and removes all previous routes.
/// Optionally accepts [arguments] to pass to the new route.
void pushAndRemoveRoute(
  BuildContext context,
  String route, {
  Object? arguments,
}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    route,
    (Route<dynamic> route) => false,
    arguments: arguments,
  );
}

/// Navigates to the given [route], optionally passing [arguments].
void pushRoute(
  BuildContext context,
  String route, {
  Object? arguments,
}) {
  Navigator.of(context).pushNamed(
    route,
    arguments: arguments,
  );
}
