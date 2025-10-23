/*
 * @class GetPokedexListUsecase
 * @description Clase encargada de contener la lógica de negocio para obtener la lista de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import '../entities/pokedex_entity.dart';
import '../repositories/pokedex_repository.dart';

class GetPokedexListUsecase {
  // Repositorio de Pokédex
  final PokedexRepository repository;
  GetPokedexListUsecase(this.repository);

  /*
  * @method call
  * @description Método que obtiene la lista de Pokédex desde el repositorio.
  */
  Future<List<PokedexEntity>> call() async {
    return await repository.getPokedexList();
  }
}
