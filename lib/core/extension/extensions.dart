
import 'package:flutter/material.dart';

extension NullableStringX on String? {
  /// Returns the string value if not null, otherwise an empty string.
  String get orEmpty => this ?? '';
}

extension NullableIntX on int? {
  /// Returns the int value if not null, otherwise zero.
  int get orZero => this ?? 0;
}

extension SizedBoxX on num {
  /// Returns a SizedBox with the given height.
  Widget get heightBox => SizedBox(height: toDouble());

  /// Returns a SizedBox with the given width.
  Widget get widthBox => SizedBox(width: toDouble());
}

extension ContextMediaQueryX on BuildContext {
  /// Returns the size of the screen.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Returns the height of the screen.
  double get screenHeight => screenSize.height;

  /// Returns the width of the screen.
  double get screenWidth => screenSize.width;

  /// Returns the top padding (e.g., status bar height).
  double get topPadding => MediaQuery.paddingOf(this).top;

  /// Returns the bottom inset (e.g., keyboard height).
  double get bottomInset => MediaQuery.viewInsetsOf(this).bottom;
}