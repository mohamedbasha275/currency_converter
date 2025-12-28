import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/features/onboarding/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnBoardingItem extends StatelessWidget {
  final OnboardingModel model;

  const OnBoardingItem({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image.asset(
            model.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading image: ${model.image} - $error');
              return Container(
                color: AppColors.primary.withOpacity(0.1),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gradientWhite,
                AppColors.gradientLight,
                AppColors.gradientMedium,
                AppColors.gradientDark,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ), // Opacity layer
        ),
        Container(
          width: context.screenWidth * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (context.screenHeight *0.25).heightBox,
              Text(
                model.title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              20.heightBox,
              Text(
                model.description,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  //fontFamily: FontConstants.iBMFontFamily,
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
