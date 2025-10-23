/*
 * @class PokedexModel
 * @description Clase encargada de modelar los datos de un Pokémon en la Pokédex.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokedex_model.freezed.dart';
part 'pokedex_model.g.dart';

@freezed
class PokedexModel with _$PokedexModel {
  const factory PokedexModel({
    required int id, // Identificador único del Pokémon
    required String name, // Nombre del Pokémon
    required String imageUrl, // URL de la imagen del Pokémon
    required List<String> types, // Tipos del Pokémon
  }) = _PokedexModel;

  factory PokedexModel.fromJson(Map<String, dynamic> json) =>
      _$PokedexModelFromJson(json);
}
