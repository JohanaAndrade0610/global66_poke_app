/*
 * @class FavoritesRepository
 * @description Interfaz del repositorio de favoritos que define los contratos de la capa de dominio.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import '../entities/favorite_entity.dart';

abstract class FavoritesRepository {
  /*
  * @method addFavorite
  * @description Agrega un Pokémon a favoritos.
  * @param favorite - Entidad del Pokémon a agregar.
  */
  Future<void> addFavorite(FavoriteEntity favorite);

  /*
  * @method removeFavorite
  * @description Elimina un Pokémon de favoritos.
  * @param pokemonId - ID del Pokémon a eliminar.
  */
  Future<void> removeFavorite(int pokemonId);

  /*
  * @method getAllFavorites
  * @description Obtiene todos los Pokémon favoritos.
  * @returns Future<List<FavoriteEntity>> Lista de favoritos.
  */
  Future<List<FavoriteEntity>> getAllFavorites();

  /*
  * @method isFavorite
  * @description Verifica si un Pokémon está en favoritos.
  * @param pokemonId - ID del Pokémon a verificar.
  * @returns Future<bool> True si está en favoritos.
  */
  Future<bool> isFavorite(int pokemonId);

  /*
  * @method toggleFavorite
  * @description Alterna el estado de favorito de un Pokémon.
  * @param favorite - Entidad del Pokémon.
  * @returns Future<bool> True si se agregó, false si se eliminó.
  */
  Future<bool> toggleFavorite(FavoriteEntity favorite);
}
