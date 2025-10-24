/*
 * @class FavoriteModel
 * @description Clase encargada de modelar los datos de un Pokémon favorito para SQLite.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/favorite_entity.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

@freezed
class FavoriteModel with _$FavoriteModel {
  const FavoriteModel._(); // Constructor privado para poder usar métodos custom

  const factory FavoriteModel({
    required int id, // Identificador único del Pokémon
    required String name, // Nombre del Pokémon
    required String imageUrl, // URL de la imagen del Pokémon
    required String types, // Tipos del Pokémon (separados por coma)
    required int addedAt, // Timestamp en milisegundos
  }) = _FavoriteModel;

  // Usa el generado automáticamente por json_serializable
  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  // Método de instancia para convertir a Map de DB
  Map<String, dynamic> toDb() => toJson();

  // Método de instancia para convertir a Entity
  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types.split(','),
      addedAt: DateTime.fromMillisecondsSinceEpoch(addedAt),
    );
  }
}

// Extension para convertir de Entity a Model
extension FavoriteEntityX on FavoriteEntity {
  FavoriteModel toModel() {
    return FavoriteModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types.join(','),
      addedAt: addedAt.millisecondsSinceEpoch,
    );
  }
}
