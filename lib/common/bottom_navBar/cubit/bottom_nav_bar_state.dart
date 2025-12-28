part of 'bottom_nav_bar_cubit.dart';

@immutable
abstract class BottomNavBarState {
  final int currentIndex;
  const BottomNavBarState(this.currentIndex);
}

class BottomNavBarInitial extends BottomNavBarState {
  const BottomNavBarInitial(super.currentIndex);
}
