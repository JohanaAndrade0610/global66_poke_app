/*
 * @class FavoritesState
 * @description Estado del provider de favoritos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/favorite_entity.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  // Estado de carga inicial
  const factory FavoritesState.loading() = _Loading;

  // Estado con lista de favoritos cargada
  const factory FavoritesState.loaded({
    required List<FavoriteEntity> favorites,
    required Set<int> favoriteIds,
  }) = _Loaded;

  // Estado de error
  const factory FavoritesState.error(String message) = _Error;
}
