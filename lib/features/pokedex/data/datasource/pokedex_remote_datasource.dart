/*
 * @class PokedexRemoteDatasource
 * @description Clase encargada de gestionar la comunicación con la API de Pokedex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:dio/dio.dart';
import '../../../../core/config.dart';

class PokedexRemoteDatasource {
  // Instancia de Dio para realizar solicitudes HTTP
  final Dio dio;
  PokedexRemoteDatasource(this.dio);

  /*
    * @method fetchPokedexList
    * @description Obtiene la lista de Pokémon desde la API de Pokedex.
    * @returns Future<List<PokedexModel>> Lista de modelos de Pokedex.
    */
  Future<List<Map<String, dynamic>>> fetchPokedexRawList() async {
    final url = '${AppConfig.pokeApiBaseUrl}/pokemon';
    final response = await dio.get(url);
    final results = response.data['results'] as List;
    return results.cast<Map<String, dynamic>>();
  }

  /*
    * @method fetchPokemonRaw
    * @description Obtiene los datos crudos de un Pokémon desde la API por nombre o URL.
    * @returns Future<Map<String, dynamic>> Datos crudos del Pokémon.
    */
  Future<Map<String, dynamic>> fetchPokemonRaw(String nameOrUrl) async {
    final url = nameOrUrl.startsWith('https')
        ? nameOrUrl
        : '${AppConfig.pokeApiBaseUrl}/pokemon/$nameOrUrl';
    final response = await dio.get(url);
    return response.data as Map<String, dynamic>;
  }

  /*
    * @method fetchTypeRaw
    * @description Obtiene los datos crudos de un tipo de Pokémon desde la API por nombre.
    * @returns Future<Map<String, dynamic>> Datos crudos del tipo de Pokémon.
    */
  Future<Map<String, dynamic>> fetchTypeRaw(String type) async {
    final url = '${AppConfig.pokeApiBaseUrl}/type/$type';
    final response = await dio.get(url);
    return response.data as Map<String, dynamic>;
  }

  /*
    * @method fetchSpeciesRaw
    * @description Obtiene los datos crudos de la especie de un Pokémon desde la API por nombre.
    * @returns Future<Map<String, dynamic>> Datos crudos de la especie del Pokémon.
    */
  Future<Map<String, dynamic>> fetchSpeciesRaw(String name) async {
    final url = '${AppConfig.pokeApiBaseUrl}/pokemon-species/$name';
    final response = await dio.get(url);
    return response.data as Map<String, dynamic>;
  }
}
