/*
 * @class PokemonDetailModel
 * @description Modelo para los detalles de un Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/pokemon_detail_entity.dart';

part 'pokemon_detail_model.freezed.dart';
part 'pokemon_detail_model.g.dart';

@freezed
class PokemonDetailModel with _$PokemonDetailModel {
  const factory PokemonDetailModel({
    required int id, // ID del Pokémon
    required String name, // Nombre del Pokémon
    required String imageUrl, // URL de la imágen del Pokémon
    required List<String> types, // Tipos del Pokémon
    required double weight, // Peso del Pokémon
    required double height, // Altura del Pokémon
    required String category, // Categoría del Pokémon
    required String ability, // Habilidad del Pokémon
    required double maleRate, // Tasa de género masculino
    required double femaleRate, // Tasa del género femenino
    required List<String> weaknesses, // Debilidades del Pokémon
    required String description, // Descripción del Pokémon
  }) = _PokemonDetailModel;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);
}

// Utilidad para convertir el modelo en entidad
extension PokemonDetailModelX on PokemonDetailModel {
  PokemonDetailEntity toEntity() {
    return PokemonDetailEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types,
      weight: weight,
      height: height,
      category: category,
      ability: ability,
      maleRate: maleRate,
      femaleRate: femaleRate,
      weaknesses: weaknesses,
      description: description,
    );
  }
}
