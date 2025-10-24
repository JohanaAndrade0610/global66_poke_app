/*
 * @class PokedexState
 * @description Clase encargada de contener los diferentes estados de la pantalla de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/pokedex_entity.dart';

part 'pokedex_state.freezed.dart';

@freezed
class PokedexState with _$PokedexState {
  // Estado de carga en la pantalla.
  const factory PokedexState.loading() = _Loading;
  // Estado con la lista de Pokémon cargada.
  const factory PokedexState.loaded(List<PokedexEntity> pokemons) = _Loaded;
  // Estado de error con mensaje descriptivo.
  const factory PokedexState.error(String error) = _Error;
}
