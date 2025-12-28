import 'package:flutter/material.dart';

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
