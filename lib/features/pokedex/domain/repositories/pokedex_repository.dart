/*
 * @class PokedexRepository
 * @description Clase encargada de gestionar la comunicación entre la capa de datos y la capa de dominio para la Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import '../entities/pokedex_entity.dart';

abstract class PokedexRepository {
  /*
    * @method getPokedexList
    * @description Obtiene la lista completa de la Pokédex.
    * @returns Future<List<PokedexEntity>> Lista de entidades de la Pokédex.
    */
  Future<List<PokedexEntity>> getPokedexList();
}
