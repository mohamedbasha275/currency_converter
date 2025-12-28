import 'package:currency_converter/app_widgets/error_widget.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      message: message,
      function: onRetry,
    );
  }
}








