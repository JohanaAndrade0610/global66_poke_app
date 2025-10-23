/*
 * @class PokedexEntity
 * @description Clase encargada de contener la información de un Pokémon en la Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokedex_entity.freezed.dart';

@freezed
class PokedexEntity with _$PokedexEntity {
  const factory PokedexEntity({
    required int id, // Identificador único del Pokémon
    required String name, // Nombre del Pokémon
    required String imageUrl, // URL de la imagen del Pokémon
    required List<String> types, // Tipos del Pokémon
  }) = _PokedexEntity;
}
