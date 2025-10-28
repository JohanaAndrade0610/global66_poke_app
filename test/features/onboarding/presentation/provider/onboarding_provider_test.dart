// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:global66_poke_app/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:global66_poke_app/features/onboarding/presentation/provider/onboarding_state.dart';

void main() {
  group('OnboardingController', () {
    late ProviderContainer container;
    late OnboardingController controller;

    setUp(() {
      container = ProviderContainer();
      controller = container.read(onboardingControllerProvider.notifier);
    });

  test('completeSplash marca splashCompleted como verdadero', () {
      controller.completeSplash();
      expect(controller.state.splashCompleted, true);
    });

  test('onSplashAnimationCompleted marca splashCompleted y navigationRoute', () {
      controller.onSplashAnimationCompleted();
      expect(controller.state.splashCompleted, true);
      expect(controller.state.navigationRoute, '/onboarding');
    });

  test('clearNavigation pone navigationRoute en null', () {
      controller.onSplashAnimationCompleted();
      controller.clearNavigation();
      expect(controller.state.navigationRoute, null);
    });

  test('ensureLoadingFalse pone loading en false', () {
      controller.state = controller.state.copyWith(loading: true);
      controller.ensureLoadingFalse();
      expect(controller.state.loading, false);
    });

  test('setCurrentPage establece la página actual', () {
      controller.setCurrentPage(1);
      expect(controller.state.currentPage, 1);
    });

  test('nextPage incrementa currentPage si es menor que 1', () {
      controller.setCurrentPage(0);
      controller.nextPage();
      expect(controller.state.currentPage, 1);
    });

  test('reset reinicia el estado a inicial', () {
      controller.setCurrentPage(1);
      controller.reset();
      expect(controller.state, const OnboardingState());
    });
  });
}
