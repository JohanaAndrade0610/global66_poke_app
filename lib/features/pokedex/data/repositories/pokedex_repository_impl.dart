/*
 * @class PokedexRepositoryImpl
 * @description Clase encargada de gestionar la comunicación entre la capa de datos y la capa de dominio para la Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import '../../domain/entities/pokedex_entity.dart';
import '../../domain/entities/pokemon_detail_entity.dart';
import '../../domain/repositories/pokedex_repository.dart';
import '../datasource/pokedex_remote_datasource.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  // Fuente de datos remota para obtener la información de la Pokédex
  final PokedexRemoteDatasource remoteDatasource;
  PokedexRepositoryImpl(this.remoteDatasource);

  /*
  * @method getPokedexList
  * @description Obtiene la lista de Pokémons desde la fuente de datos remota y la convierte en una lista de entidades Pokedex.
  * @returns Future<List<Pokedex>> Lista de Pokémons en formato de entidad Pokedex.
  */
  @override
  Future<List<PokedexEntity>> getPokedexList() async {
    final models = await remoteDatasource.fetchPokedexList();
    return models
        .map(
          (m) => PokedexEntity(
            id: m.id,
            name: m.name,
            imageUrl: m.imageUrl,
            types: m.types,
          ),
        )
        .toList();
  }

  /*
  * @method getPokemonDetail
  * @description Obtiene los detalles de un Pokémon específico desde la fuente de datos remota y los convierte en una entidad PokemonDetail.
  * @param String name Nombre del Pokémon.
  * @returns Future<PokemonDetailEntity> Detalles del Pokémon en formato de entidad PokemonDetail.
  */
  @override
  Future<PokemonDetailEntity> getPokemonDetail(String name) async {
    final model = await remoteDatasource.fetchPokemonDetail(name);
    return PokemonDetailEntity(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
      types: model.types,
      weight: model.weight,
      height: model.height,
      category: model.category,
      ability: model.ability,
      maleRate: model.maleRate,
      femaleRate: model.femaleRate,
      weaknesses: model.weaknesses,
      description: model.description,
    );
  }
}
