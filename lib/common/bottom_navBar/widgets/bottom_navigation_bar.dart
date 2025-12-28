import 'package:currency_converter/common/bottom_navBar/cubit/bottom_nav_bar_cubit.dart';
import 'package:currency_converter/common/bottom_navBar/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final BottomNavBarCubit cubit;

  const AppBottomNavigationBar({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, int>(
      bloc: cubit,
      builder: (context, currentIndex) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ClipRRect(
            //  borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: currentIndex,
                onTap: cubit.changeIndex,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                showSelectedLabels: false,
                selectedFontSize: 0,
                showUnselectedLabels: false,
                unselectedFontSize: 0,
                items: List.generate(
                  cubit.navItems.length, (index) {
                    final item = cubit.navItems[index];
                    return BottomNavigationBarItem(
                      label: item.label,
                      icon: BottomNavBarItem(
                        navbarModel: item,
                        isActive: currentIndex == index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

