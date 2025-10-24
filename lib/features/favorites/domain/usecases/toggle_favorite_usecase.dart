/*
 * @class ToggleFavoriteUsecase
 * @description Caso de uso para alternar el estado de favorito de un Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import '../entities/favorite_entity.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavoriteUsecase {
  // Repositorio de favoritos
  final FavoritesRepository repository;

  ToggleFavoriteUsecase(this.repository);

  /*
  * @method call
  * @description Alterna el estado de favorito de un Pokémon.
  * @param favorite - Entidad del Pokémon.
  * @returns Future<bool> True si se agregó a favoritos, false si se eliminó.
  */
  Future<bool> call(FavoriteEntity favorite) async {
    return await repository.toggleFavorite(favorite);
  }
}
