/*
 * @class PokedexRemoteDatasource
 * @description Clase encargada de gestionar la comunicación con la API de Pokedex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:dio/dio.dart';
import '../../../../core/config.dart';
import '../models/pokedex_model.dart';

class PokedexRemoteDatasource {
  // Instancia de Dio para realizar solicitudes HTTP
  final Dio dio;
  PokedexRemoteDatasource(this.dio);

  /*
    * @method fetchPokedexList
    * @description Obtiene la lista de Pokémon desde la API de Pokedex.
    * @returns Future<List<PokedexModel>> Lista de modelos de Pokedex.
    */
  Future<List<PokedexModel>> fetchPokedexList() async {
    // Url de la API para obtener la lista de Pokémon
    final url = '${AppConfig.pokeApiBaseUrl}/pokemon';
    // Realizar la solicitud GET
    final response = await dio.get(url);
    final results = response.data['results'] as List;
    // Para cada Pokémon, obtener detalles mediante la url (id, nombre, imagen, tipos)
    final List<PokedexModel> pokemons = [];
    for (var item in results) {
      final detail = await dio.get(item['url']);
      pokemons.add(
        PokedexModel(
          id: detail.data['id'],
          name: detail.data['name'],
          imageUrl: detail.data['sprites']['front_default'],
          types: (detail.data['types'] as List)
              .map((t) => t['type']['name'] as String)
              .toList(),
        ),
      );
    }
    return pokemons;
  }
}
