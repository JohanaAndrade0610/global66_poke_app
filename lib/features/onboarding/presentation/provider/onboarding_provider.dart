/*
 * @class OnboardingController
 * @description Clase encargada de gestionar el estado de la pantalla de onboarding,
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

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
      navigationRoute: '/onboarding', // Ruta a la que se debe navegar después del splash
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
    state = state.copyWith(loading: true);
    try {
      await ref.read(pokedexProvider.notifier).fetchPokemonsForOnboarding();
      state = state.copyWith(
        completed: true,
        canNavigateToPokedex: true,
        navigationRoute: '/pokedex', // Ruta a la que se debe navegar después de cargar los datos
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        navigationRoute: '/pokedex', // Ruta a la que se debe navegar en caso de error
      );
    }
  }

  /*
    * @method reset
    * @description Método encargado de reiniciar el estado de la pantalla onboarding.
    */
  void reset() {
    state = const OnboardingState();
  }
}
