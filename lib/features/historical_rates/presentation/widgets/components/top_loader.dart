import 'package:flutter/material.dart';

class TopLoader extends StatelessWidget {
  const TopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: LinearProgressIndicator(
        minHeight: 2,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(Color(0xFF2F6BFF)),
      ),
    );
  }
}








