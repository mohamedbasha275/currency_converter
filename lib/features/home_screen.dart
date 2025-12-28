import 'package:currency_converter/common/animations/app_animations.dart';
import 'package:currency_converter/common/bottom_navBar/cubit/bottom_nav_bar_cubit.dart';
import 'package:currency_converter/common/bottom_navBar/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBarCubit(),
      child: BlocBuilder<BottomNavBarCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<BottomNavBarCubit>();
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(),
            ),
            //body: IndexedStack(index: currentIndex, children: cubit.tabs),
            body: AnimatedTabContent(
              currentIndex: cubit.currentIndex,
              child: cubit.tabs[cubit.currentIndex],
            ),
            bottomNavigationBar: AppBottomNavigationBar(cubit: cubit),
          );
        },
      ),
    );
  }
}
