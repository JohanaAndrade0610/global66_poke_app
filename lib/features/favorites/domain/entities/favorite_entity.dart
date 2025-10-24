/*
 * @class FavoriteEntity
 * @description Clase encargada de contener la información de un Pokémon favorito.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_entity.freezed.dart';

@freezed
class FavoriteEntity with _$FavoriteEntity {
  const factory FavoriteEntity({
    required int id, // Identificador único del Pokémon
    required String name, // Nombre del Pokémon
    required String imageUrl, // URL de la imagen del Pokémon
    required List<String> types, // Tipos del Pokémon
    required DateTime addedAt, // Fecha en que se agregó a favoritos
  }) = _FavoriteEntity;
}
