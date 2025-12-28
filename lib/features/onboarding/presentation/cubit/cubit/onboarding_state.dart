// features/onboarding/presentation/cubit/cubit/onboarding_state.dart
part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingcubitInitial extends OnboardingState {}
final class OnboardingChangepage extends OnboardingState {}

