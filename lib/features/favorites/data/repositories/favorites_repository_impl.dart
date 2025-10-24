/*
 * @class FavoritesRepositoryImpl
 * @description Implementación del repositorio de favoritos que conecta con el datasource local.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasource/favorites_local_datasource.dart';
import '../models/favorite_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  // Fuente de datos local
  final FavoritesLocalDatasource localDatasource;

  FavoritesRepositoryImpl(this.localDatasource);

  /*
  * @method addFavorite
  * @description Agrega un Pokémon a favoritos.
  * @param favorite - Entidad del Pokémon a agregar.
  */
  @override
  Future<void> addFavorite(FavoriteEntity favorite) async {
    final model = favorite.toModel();
    await localDatasource.addFavorite(model);
  }

  /*
  * @method removeFavorite
  * @description Elimina un Pokémon de favoritos.
  * @param pokemonId - ID del Pokémon a eliminar.
  */
  @override
  Future<void> removeFavorite(int pokemonId) async {
    await localDatasource.removeFavorite(pokemonId);
  }

  /*
  * @method getAllFavorites
  * @description Obtiene todos los Pokémon favoritos.
  */
  @override
  Future<List<FavoriteEntity>> getAllFavorites() async {
    final models = await localDatasource.getAllFavorites();
    return models.map((model) => model.toEntity()).toList();
  }

  /*
  * @method isFavorite
  * @description Verifica si un Pokémon está en favoritos.
  * @param pokemonId - ID del Pokémon a verificar.
  */
  @override
  Future<bool> isFavorite(int pokemonId) async {
    return await localDatasource.isFavorite(pokemonId);
  }

  /*
  * @method toggleFavorite
  * @description Alterna el estado de favorito de un Pokémon.
  * @param favorite - Entidad del Pokémon.
  * @returns True si se agregó, false si se eliminó.
  */
  @override
  Future<bool> toggleFavorite(FavoriteEntity favorite) async {
    final isFav = await isFavorite(favorite.id);
    if (isFav) {
      await removeFavorite(favorite.id);
      return false;
    } else {
      await addFavorite(favorite);
      return true;
    }
  }
}
