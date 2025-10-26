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
  */
  @override
  Future<List<PokedexEntity>> getPokedexList() async {
    final rawList = await remoteDatasource.fetchPokedexRawList();
    final List<PokedexEntity> pokemons = [];
    for (var item in rawList) {
      final detail = await remoteDatasource.fetchPokemonRaw(
        item['url'] as String,
      );
      pokemons.add(_parsePokedexEntity(detail));
    }
    return pokemons;
  }

  /* @method _parsePokedexEntity
  * @description Convierte los datos crudos de un Pokémon en una entidad Pokedex.
  * @param Map<String, dynamic> detail Datos crudos del Pokémon.
  */
  PokedexEntity _parsePokedexEntity(Map<String, dynamic> detail) {
    return PokedexEntity(
      id: detail['id'] as int,
      name: detail['name'] as String,
      imageUrl: detail['sprites']['front_default'] as String,
      types: (detail['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
    );
  }

  /*
  * @method getPokemonDetail
  * @description Obtiene los detalles de un Pokémon específico desde la fuente de datos remota y los convierte en una entidad PokemonDetail.
  * @param String name Nombre del Pokémon.
  */
  @override
  Future<PokemonDetailEntity> getPokemonDetail(String name) async {
    final data = await remoteDatasource.fetchPokemonRaw(name);
    final types = _parseTypes(data);
    final ability = _parseAbility(data);
    final weaknesses = await _fetchWeaknesses(types);
    final speciesData = await remoteDatasource.fetchSpeciesRaw(name);
    final genderRates = _parseGenderRates(speciesData);
    final category = _parseCategory(speciesData);
    final description = _parseDescription(speciesData);
    return PokemonDetailEntity(
      id: data['id'] as int,
      name: data['name'] as String,
      imageUrl: data['sprites']['front_default'] as String,
      types: types,
      weight: (data['weight'] as num).toDouble() / 10,
      height: (data['height'] as num).toDouble() / 10,
      category: category,
      ability: ability,
      maleRate: genderRates['male'] ?? 0,
      femaleRate: genderRates['female'] ?? 0,
      weaknesses: weaknesses,
      description: description,
    );
  }

  /*
  * @method _parseTypes
  * @description Extrae los tipos de un Pokémon desde sus datos crudos.
  * @param Map<String, dynamic> data Datos crudos del Pokémon.
  */
  List<String> _parseTypes(Map<String, dynamic> data) {
    return (data['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();
  }

  /*
  * @method _parseAbility
  * @description Extrae la habilidad de un Pokémon desde sus datos crudos.
  * @param Map<String, dynamic> data Datos crudos del Pokémon.
  */
  String _parseAbility(Map<String, dynamic> data) {
    final abilities = data['abilities'] as List;
    return abilities.isNotEmpty
        ? abilities[0]['ability']['name'] as String
        : '';
  }

  /*
  * @method _fetchWeaknesses
  * @description Obtiene las debilidades de un Pokémon basado en sus tipos.
  * @param List<String> types Lista de tipos del Pokémon.
  */
  Future<List<String>> _fetchWeaknesses(List<String> types) async {
    if (types.isEmpty) return [];
    final typeData = await remoteDatasource.fetchTypeRaw(types[0]);
    return (typeData['damage_relations']['double_damage_from'] as List)
        .map((w) => w['name'] as String)
        .toList();
  }

  /*
  * @method _parseGenderRates
  * @description Extrae las tasas de género de un Pokémon desde sus datos crudos.
  * @param Map<String, dynamic> speciesData Datos crudos del Pokémon.
  */
  Map<String, double> _parseGenderRates(Map<String, dynamic> speciesData) {
    double maleRate = 0;
    double femaleRate = 0;
    if (speciesData['gender_rate'] != null &&
        speciesData['gender_rate'] != -1) {
      maleRate = (8 - speciesData['gender_rate']) / 8 * 100;
      femaleRate = (speciesData['gender_rate']) / 8 * 100;
    }
    return {'male': maleRate, 'female': femaleRate};
  }

  /*
  * @method _parseCategory
  * @description Extrae la categoría de un Pokémon desde sus datos crudos.
  * @param Map<String, dynamic> speciesData Datos crudos del Pokémon.
  */
  String _parseCategory(Map<String, dynamic> speciesData) {
    final genera = speciesData['genera'] as List;
    if (genera.isNotEmpty) {
      return genera.firstWhere(
            (g) => g['language']['name'] == 'es',
            orElse: () => genera[0],
          )['genus']
          as String;
    }
    return '';
  }

  /*
  * @method _parseDescription
  * @description Extrae la descripción de un Pokémon desde sus datos crudos.
  * @param Map<String, dynamic> speciesData Datos crudos del Pokémon.
  */
  String _parseDescription(Map<String, dynamic> speciesData) {
    final entries = speciesData['flavor_text_entries'] as List;
    if (entries.isNotEmpty) {
      final entry = entries.firstWhere(
        (e) => e['language']['name'] == 'es',
        orElse: () => null,
      );
      if (entry != null) {
        return (entry['flavor_text'] as String)
            .replaceAll('\n', ' ')
            .replaceAll('\f', ' ');
      }
    }
    return '';
  }
}
