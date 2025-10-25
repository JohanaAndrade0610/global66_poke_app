/*
 * @class PokemonDetailEntity
 * @description Entidad para el detalle de un Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail_entity.freezed.dart';

@freezed
class PokemonDetailEntity with _$PokemonDetailEntity {
  const factory PokemonDetailEntity({
    required int id, // ID del Pokémon
    required String name, // Nombre del Pokémon
    required String imageUrl, // URL de la imágen del Pokémon
    required List<String> types, // Tipos del Pokémon
    required double weight, // Peso del Pokémon
    required double height, // Altiura del Pokémon
    required String category, // Categoría del Pokémon
    required String ability, // Habilidad del Pokémon
    required double maleRate, // Tasa de género masculino
    required double femaleRate, // Tasa de género femenino
    required List<String> weaknesses, // Debilidades del Pokémon
  }) = _PokemonDetailEntity;
}
