/*
 * @widget PokemonTypeLabel
 * @description Widget encargado de mostrar la etiqueta del tipo y debilidades del Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/pokedex/presentation/utils/pokemon_type_localization.dart';
import '../theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

class PokemonTypeLabel extends StatelessWidget {
  // Tipo o debilidad del Pokémon
  final String type;
  // Internacionalización del texto del tipo o debilidad
  final AppLocalizations l10n;

  const PokemonTypeLabel({Key? key, required this.type, required this.l10n})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el nombre traducido del tipo o debilidad del Pokémon
    final typeNameTranslated = getPokemonTypeTranslatedName(type, l10n);
    // Obtener el color del tipo o debilidad del Pokémon
    final typeColor = PokemonTypeColors.getTypeColor(type);
    // Obtener el ícono del tipo o debilidad del Pokémon
    final typeIconPath = PokemonTypeColors.getTypeLabelLogoPath(type);

    return Container(
      // Diseño de la etiqueta
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: typeColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ícono del tipo o debilidad
          SvgPicture.asset(typeIconPath, width: 20, height: 20),
          const SizedBox(width: 5),
          // Nombre del tipo o debilidad del Pokémon
          Text(
            typeNameTranslated,
            style: AppTextStyles.textPoppins11MediumFAFAFA,
          ),
        ],
      ),
    );
  }
}
