/*
 * @class GetPokedexListUsecase
 * @description Clase encargada de contener la lógica de negocio para obtener la lista de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import '../entities/pokedex_entity.dart';
import '../repositories/pokedex_repository.dart';
import '../pagination/pagination_policy.dart';

class GetPokedexListUsecase {
  // Repositorio de Pokédex
  final PokedexRepository repository;
  // Política de paginación
  final PaginationPolicy paginationPolicy;

  GetPokedexListUsecase(this.repository, this.paginationPolicy);

  /*
  * @method call
  * @description Método que obtiene la lista de Pokédex desde el repositorio.
  * @param offset - Desplazamiento para la paginación.
  */
  Future<List<PokedexEntity>> call({int offset = 0}) async {
    return repository.getPokedexList(
      limit: paginationPolicy.pageSize,
      offset: offset,
    );
  }
}
