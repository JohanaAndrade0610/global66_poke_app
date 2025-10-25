/*
 * @class PokemonDetailState
 * @description Estado para la pantalla de detalle de Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/pokemon_detail_entity.dart';

part 'pokemon_detail_state.freezed.dart';

@freezed
class PokemonDetailState with _$PokemonDetailState {
  // Estado de carga
  const factory PokemonDetailState.loading() = _Loading;
  // Estado cargado el detalle del Pokémon
  const factory PokemonDetailState.loaded(PokemonDetailEntity detail) = _Loaded;
  // Estado de error
  const factory PokemonDetailState.error(String error) = _Error;
}
