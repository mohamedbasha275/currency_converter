// features/onboarding/presentation/cubit/cubit/onboarding_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/di/service_locator.dart';
import 'package:currency_converter/core/resources/app_assets.dart';
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';
import 'package:currency_converter/features/onboarding/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingcubitInitial()) {
    _loadOnboardingData();
  }

  static OnboardingCubit get(context) => BlocProvider.of(context);

  bool isLast = false;
  final pageController = PageController();
  int currentPage = 1;
  List<OnboardingModel> boardingsList = [];

  void _loadOnboardingData() {
    boardingsList = [
      OnboardingModel(
        image: ImageAssets.onBoarding1,
        title: 'Convert currencies instantly',
        description: 'Easily convert between global currencies using real-time exchange rates.',
      ),

      OnboardingModel(
        image: ImageAssets.onBoarding2,
        title: 'Browse all currencies',
        description: 'Explore a complete list of supported currencies with country details.',
      ),

      OnboardingModel(
        image: ImageAssets.onBoarding3,
        title: 'Track exchange history',
        description: 'View historical exchange rates and analyze currency trends over time.',
      ),

      OnboardingModel(
        image: ImageAssets.onBoarding4,
        title: 'Stay updated anywhere',
        description: 'Access accurate currency data anytime, even when switching currencies.',
      ),

    ];
  }

  void changePage({required int index}) {
    currentPage = index + 1;
    if (index == boardingsList.length - 1) {
      isLast = true;
    } else {
      isLast = false;
    }
    emit(OnboardingChangepage());
  }


  void setOnboardingViewed()  {
    AppPreferences appPreferences = getIt.get<AppPreferences>();
     appPreferences.setOnBoardingScreenViewed();
  }
}
