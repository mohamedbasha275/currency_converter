import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/navigation/app_routers.dart';
import 'package:currency_converter/core/navigation/route_navigate.dart';
import 'package:currency_converter/core/helper_functions/system_bar.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_constants.dart';
import 'package:currency_converter/features/onboarding/presentation/cubit/cubit/onboarding_cubit.dart';
import 'package:currency_converter/features/onboarding/presentation/views/widgets/onboarding_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends HookWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boardController = usePageController();
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: AppColors.gradientMedium,
        extendBodyBehindAppBar: true,
        appBar: SystemBarHelper.onBoardingTopBar,
        body: BlocConsumer<OnboardingCubit, OnboardingState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = OnboardingCubit.get(context);
            return Stack(
              children: [
                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (index) {
                    cubit.changePage(index: index);
                  },
                  itemCount: cubit.boardingsList.length,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: boardController,
                      builder: (context, child) {
                        double value = 1.0;

                        if (boardController.position.haveDimensions) {
                          value = (boardController.page! - index).abs();
                          value = (1 - (value * 0.25)).clamp(0.0, 1.0);
                        }

                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            //offset: Offset(0, 30 * (1 - value)),
                            child: Transform.scale(
                              scale: value,
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: OnBoardingItem(
                        model: cubit.boardingsList[index],
                      ),
                    );
                  },
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom:  30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          cubit.setOnboardingViewed();
                         pushAndRemoveRoute(context, AppRoutes.home);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom:  8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width:  2,
                              ),
                            ),
                          ),
                          child: Text(
                            'Skip',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Colors.white,
                              fontSize:  16,
                            ),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: boardController,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.white70,
                          activeDotColor: AppColors.activeOnboarding,
                          dotHeight: 8,
                          expansionFactor: 2.5,
                          dotWidth: 8,
                          spacing: 8,
                        ),
                        count: cubit.boardingsList.length,
                      ),
                      CircularPercentIndicator(
                        radius: 35,
                        center: TextButton(
                          style: ButtonStyle(
                            enableFeedback: false,
                            overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            if (cubit.isLast) {
                              cubit.setOnboardingViewed();
                              pushAndRemoveRoute(context, AppRoutes.home);
                            } else {
                              boardController.nextPage(
                                duration: AppConstants.onBoardingPageSpeed,
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            }
                          },
                          child: Container(
                            width: 45,
                            height:  45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular( 40),
                              color: (cubit.isLast)
                                  ? AppColors.activeOnboarding
                                  :  Colors.white70,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                        percent: cubit.currentPage / cubit.boardingsList.length,
                        backgroundColor: Colors.white70,
                        progressColor: AppColors.activeOnboarding,
                        animateFromLastPercent: true,
                        animation: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
