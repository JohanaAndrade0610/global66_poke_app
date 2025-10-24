/*
 * @class PokedexNotifier
 * @description Clase encargada de contener el gestor de estado de la pantalla de Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/pokedex_entity.dart';
import 'pokedex_state.dart';
import '../../domain/usecases/get_pokedex_list_usecase.dart';
import '../../../../di/injection.dart';

part 'pokedex_provider.g.dart';

@riverpod
class PokedexNotifier extends _$PokedexNotifier {
  // Lista completa de Pokémon (sin filtrar)
  List<PokedexEntity> _allPokemons = [];

  /*
  * @method build
  * @description Método inicializador del estado del proveedor de Pokédex.
  */
  @override
  PokedexState build() {
    ref.keepAlive();
    return const PokedexState.loaded(pokemons: []);
  }

  /*
  * @method fetchPokedexList
  * @description Método encargado de obtener la lista de Pokémon desde el repositorio.
  * @param rethrowOnError - Indica si se debe relanzar la excepción en caso de error.
  */
  Future<void> fetchPokedexList({bool rethrowOnError = false}) async {
    state = const PokedexState.loading();
    try {
      final usecase = getIt<GetPokedexListUsecase>();
      final pokemons = await usecase.call();
      _allPokemons = pokemons;
      state = PokedexState.loaded(pokemons: pokemons);
    } catch (e) {
      state = PokedexState.error(e.toString());
      if (rethrowOnError) rethrow;
    }
  }

  /*
  * @method updateSearchQuery
  * @description Actualiza el query de búsqueda y filtra la lista.
  * @param query - Texto de búsqueda (número o nombre).
  */
  void updateSearchQuery(String query) {
    state.whenOrNull(
      loaded: (pokemons, currentQuery, selectedTypes) {
        state = PokedexState.loaded(
          pokemons: _getFilteredPokemons(query, selectedTypes),
          searchQuery: query,
          selectedTypes: selectedTypes,
        );
      },
    );
  }

  /*
  * @method updateSelectedTypes
  * @description Actualiza los tipos seleccionados para filtrar.
  * @param types - Lista de tipos seleccionados.
  */
  void updateSelectedTypes(List<String> types) {
    state.whenOrNull(
      loaded: (pokemons, searchQuery, currentTypes) {
        state = PokedexState.loaded(
          pokemons: _getFilteredPokemons(searchQuery, types),
          searchQuery: searchQuery,
          selectedTypes: types,
        );
      },
    );
  }

  /*
  * @method _getFilteredPokemons
  * @description Filtra la lista de Pokémon por búsqueda y tipos.
  * @param query - Texto de búsqueda.
  * @param types - Tipos seleccionados.
  * @return Lista filtrada de Pokémon.
  */
  List<PokedexEntity> _getFilteredPokemons(String query, List<String> types) {
    var filtered = _allPokemons;

    // Filtrar por búsqueda (número o nombre)
    if (query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      filtered = filtered.where((pokemon) {
        // Formatear ID con ceros a la izquierda (0001, 0002, etc.)
        final formattedId = pokemon.id.toString().padLeft(4, '0');
        // Buscar por número (ID) formateado o sin formatear
        final matchesId =
            formattedId.contains(lowerQuery) ||
            pokemon.id.toString().contains(lowerQuery);
        // Buscar por nombre
        final matchesName = pokemon.name.toLowerCase().contains(lowerQuery);
        return matchesId || matchesName;
      }).toList();
    }

    // Filtrar por tipos
    if (types.isNotEmpty) {
      filtered = filtered.where((pokemon) {
        // El Pokémon debe tener al menos uno de los tipos seleccionados
        return pokemon.types.any((type) => types.contains(type.toLowerCase()));
      }).toList();
    }

    return filtered;
  }
}
