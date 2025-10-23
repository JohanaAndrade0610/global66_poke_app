/*
 * @class OnboardingState
 * @description Clase encargada de gestionar el estado de la pantalla de onboarding.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false)
    bool splashCompleted, // Indica si la pantalla de splash ha sido completada
    @Default(0) int currentPage, // Página actual del onboarding
    @Default(false)
    bool loading, // Indica si se está cargando los datos de la API
    @Default(false)
    bool completed, // Indica si se ha completado la acción de onboarding
    @Default(null) String? error, // Mensaje de error en caso de fallo
    @Default(false)
    bool
    canNavigateToPokedex, // Indica si se puede navegar a la pantalla Pokedex.
    @Default(null) String? navigationRoute, // Ruta a la que se debe navegar.
  }) = _OnboardingState;
}
