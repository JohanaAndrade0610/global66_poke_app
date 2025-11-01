/*
 * @class OnboardingController
 * @description Clase encargada de gestionar el estado de la pantalla de onboarding,
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../pokedex/presentation/provider/pokedex_provider.dart';
import 'onboarding_state.dart';

part 'onboarding_provider.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingState build() => const OnboardingState();

  /*
    * @method completeSplash
    * @description Método encargado de indicar que la animación del splash ha finalizado.
    */
  void completeSplash() {
    state = state.copyWith(splashCompleted: true);
  }

  /*
    * @method onSplashAnimationCompleted
    * @description Método encargado de manejar la lógica después de que la animación del splash haya finalizado.
    */
  void onSplashAnimationCompleted() {
    state = state.copyWith(
      splashCompleted: true,
      navigationRoute:
          '/onboarding', // Ruta a la que se debe navegar después del splash
    );
  }

  /*
    * @method clearNavigation
    * @description Método encargado de limpiar la ruta de navegación después de que se haya navegado.
    */
  void clearNavigation() {
    state = state.copyWith(navigationRoute: null);
  }

  /*
    * @method ensureLoadingFalse
    * @description Método encargado de asegurar que el loading se vuelva false despues de navegar a Pokedex.
    */
  void ensureLoadingFalse() {
    state = state.copyWith(loading: false);
  }

  /*
    * @method setCurrentPage
    * @description Método encargado de establecer la página actual de la pantalla onboarding.
    * @param page Página actual.
    */
  void setCurrentPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  /*
    * @method nextPage
    * @description Método encargado de avanzar a la siguiente página de la pantalla onboarding.
    */
  void nextPage() {
    if (state.currentPage < 1) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  /*
    * @method callApiPokedex
    * @description Método encargado de llamar a la API para obtener los datos necesarios para la pantalla Pokedex.
    */
  Future<void> callApiPokedex() async {
    // Navegar inmediatamente a Pokedex y cargar datos en segundo plano
    state = state.copyWith(
      loading: false,
      completed: false,
      canNavigateToPokedex: true,
      navigationRoute: '/pokedex',
    );

    // Disparar la carga sin bloquear la navegación; Pokedex mostrará skeleton mientras tanto
    unawaited(ref.read(pokedexNotifierProvider.notifier).fetchPokedexList());
  }

  /*
    * @method reset
    * @description Método encargado de reiniciar el estado de la pantalla onboarding.
    */
  void reset() {
    state = const OnboardingState();
  }
}
