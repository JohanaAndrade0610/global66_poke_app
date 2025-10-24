/*
 * @class GetAllFavoritesUsecase
 * @description Caso de uso para obtener todos los Pokémon favoritos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import '../entities/favorite_entity.dart';
import '../repositories/favorites_repository.dart';

class GetAllFavoritesUsecase {
  // Repositorio de favoritos
  final FavoritesRepository repository;

  GetAllFavoritesUsecase(this.repository);

  /*
  * @method call
  * @description Obtiene todos los Pokémon favoritos.
  * @returns Future<List<FavoriteEntity>> Lista de favoritos.
  */
  Future<List<FavoriteEntity>> call() async {
    return await repository.getAllFavorites();
  }
}
