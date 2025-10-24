/*
 * @class IsFavoriteUsecase
 * @description Caso de uso para verificar si un Pokémon está en favoritos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import '../repositories/favorites_repository.dart';

class IsFavoriteUsecase {
  // Repositorio de favoritos
  final FavoritesRepository repository;

  IsFavoriteUsecase(this.repository);

  /*
  * @method call
  * @description Verifica si un Pokémon está en favoritos.
  * @param pokemonId - ID del Pokémon a verificar.
  * @returns Future<bool> True si está en favoritos.
  */
  Future<bool> call(int pokemonId) async {
    return await repository.isFavorite(pokemonId);
  }
}
