/*
 * @class PokemonTypeLocalization
 * @description Clase encargada de gestionar la internacionalización de los tipos de Pokémon.
 * @autor Angela Andrade
 * @version 1.0 23/10/2025 Documentación y creación de la clase.
 */

import '../../../../l10n/app_localizations.dart';

// Mapa que asocia los tipos de Pokémon con sus getters de localización
final Map<String, String Function(AppLocalizations)> pokemonTypeL10nMap = {
  'bug': (l10n) => l10n.pokemonTypeBug,
  'dark': (l10n) => l10n.pokemonTypeDark,
  'dragon': (l10n) => l10n.pokemonTypeDragon,
  'electric': (l10n) => l10n.pokemonTypeElectric,
  'fairy': (l10n) => l10n.pokemonTypeFairy,
  'fighting': (l10n) => l10n.pokemonTypeFighting,
  'fire': (l10n) => l10n.pokemonTypeFire,
  'flying': (l10n) => l10n.pokemonTypeFlying,
  'ghost': (l10n) => l10n.pokemonTypeGhost,
  'grass': (l10n) => l10n.pokemonTypeGrass,
  'ground': (l10n) => l10n.pokemonTypeGround,
  'ice': (l10n) => l10n.pokemonTypeIce,
  'normal': (l10n) => l10n.pokemonTypeNormal,
  'poison': (l10n) => l10n.pokemonTypePoison,
  'psychic': (l10n) => l10n.pokemonTypePsychic,
  'rock': (l10n) => l10n.pokemonTypeRock,
  'steel': (l10n) => l10n.pokemonTypeSteel,
  'water': (l10n) => l10n.pokemonTypeWater,
};

// Función para obtener el nombre traducido de un tipo de Pokémon
String getPokemonTypeTranslatedName(String type, AppLocalizations l10n) {
  final key = type.toLowerCase();
  final getter = pokemonTypeL10nMap[key];
  if (getter != null) {
    return getter(l10n);
  }
  return key[0].toUpperCase() + key.substring(1);
}
