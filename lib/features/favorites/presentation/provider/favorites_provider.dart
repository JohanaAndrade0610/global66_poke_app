/*
 * @class FavoritesNotifier
 * @description Provider que gestiona el estado de favoritos usando Riverpod.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../di/injection.dart';
import '../../../pokedex/domain/entities/pokedex_entity.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/usecases/get_all_favorites_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import 'favorites_state.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  /*
  * @method build
  * @description Inicializa el estado del provider.
  */
  @override
  FavoritesState build() {
    ref.keepAlive();
    return const FavoritesState.loaded(favorites: [], favoriteIds: {});
  }

  /*
  * @method loadFavorites
  * @description Carga todos los favoritos desde la base de datos local.
  */
  Future<void> loadFavorites() async {
    state = const FavoritesState.loading();
    try {
      final usecase = getIt<GetAllFavoritesUsecase>();
      final favorites = await usecase.call();
      final favoriteIds = favorites.map((f) => f.id).toSet();
      state = FavoritesState.loaded(
        favorites: favorites,
        favoriteIds: favoriteIds,
      );
    } catch (e) {
      state = FavoritesState.error(e.toString());
    }
  }

  /*
  * @method toggleFavorite
  * @description Alterna el estado de favorito de un Pokémon.
  * @param pokemon - Pokémon del cual alternar el estado de favorito.
  */
  Future<void> toggleFavorite(PokedexEntity pokemon) async {
    try {
      final usecase = getIt<ToggleFavoriteUsecase>();
      final favorite = FavoriteEntity(
        id: pokemon.id,
        name: pokemon.name,
        imageUrl: pokemon.imageUrl,
        types: pokemon.types,
        addedAt: DateTime.now(),
      );
      final wasAdded = await usecase.call(favorite);
      // Actualizar el estado localmente
      state.maybeWhen(
        loaded: (currentFavorites, currentFavoriteIds) {
          if (wasAdded) {
            // Se agrega a favoritos
            state = FavoritesState.loaded(
              favorites: [favorite, ...currentFavorites],
              favoriteIds: {...currentFavoriteIds, pokemon.id},
            );
          } else {
            // Se elimina de favoritos
            state = FavoritesState.loaded(
              favorites: currentFavorites
                  .where((f) => f.id != pokemon.id)
                  .toList(),
              favoriteIds: currentFavoriteIds
                  .where((id) => id != pokemon.id)
                  .toSet(),
            );
          }
        },
        orElse: () {
          // Si no está en estado loaded, recargar
          loadFavorites();
        },
      );
    } catch (e) {
      // En caso de error, recargar los favoritos
      await loadFavorites();
    }
  }

  /*
  * @method isFavorite
  * @description Verifica si un Pokémon está en favoritos.
  * @param pokemonId - ID del Pokémon a verificar.
  * @returns bool True si está en favoritos.
  */
  bool isFavorite(int pokemonId) {
    return state.maybeWhen(
      loaded: (favorites, favoriteIds) => favoriteIds.contains(pokemonId),
      orElse: () => false,
    );
  }
}
