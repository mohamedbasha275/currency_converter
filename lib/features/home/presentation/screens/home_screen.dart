import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: 
  Column(
    children: [
      Text('Home'),
      TextField(
        decoration: InputDecoration(
          hintText: 'Enter the amount',
        ),
      ),
      TextField(
        decoration: InputDecoration(
          hintText: 'Enter the amount',
        ),
      ),
    ],
  )
      );
      
  }
}


