/*
 * @class GetPokemonDetailUsecase
 * @description Usecase para obtener el detalle de un Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025
 */

import '../entities/pokemon_detail_entity.dart';
import '../repositories/pokedex_repository.dart';

class GetPokemonDetailUsecase {
  // Repositorio de Pokedex
  final PokedexRepository repository;
  GetPokemonDetailUsecase(this.repository);

  /*
  * @method call
  * @description Obtiene el detalle de un Pokémon por su nombre.
  * @param String name Nombre del Pokémon.
  * @returns Future<PokemonDetailEntity> Detalle del Pokémon.
  */
  Future<PokemonDetailEntity> call(String name) async {
    return await repository.getPokemonDetail(name);
  }
}
