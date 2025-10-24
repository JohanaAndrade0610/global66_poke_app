/*
 * @widget PokedexTypeFilterCard
 * @description Widget que contiene el card desplegable con los tipos de Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Creación del widget de filtro por tipos.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../utils/pokemon_type_localization.dart' as type_localization;

class PokedexTypeFilterCard extends StatelessWidget {
  // Lista de todos los tipos de Pokémon disponibles
  final List<String> allTypes;
  // Lista temporal de tipos seleccionados mientras el modal está abierto
  final List<String> tempSelectedTypes;
  // Controla si el card de tipos está expandido
  final bool isTypeCardExpanded;
  // Internacionalización de los textos del card
  final AppLocalizations l10n;
  // Función para actualizar el estado del modal
  final StateSetter setModalState;
  // Callback para agregar o quitar un tipo de la lista temporal de tipos seleccionados
  final void Function(String) onToggleType;

  const PokedexTypeFilterCard({
    Key? key,
    required this.allTypes,
    required this.tempSelectedTypes,
    required this.isTypeCardExpanded,
    required this.l10n,
    required this.setModalState,
    required this.onToggleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Contenedor del card de tipos
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteFFFFFF,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.greyE0E0E0, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setModalState(() {});
              },
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Etiqueta "Tipo"
                    Text(
                      l10n.pokedexLabelType,
                      style: AppTextStyles.textPoppins14SemiBold121212,
                    ),
                    // Icono de flecha para expandir/colapsar el card
                    Icon(
                      isTypeCardExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.grey757575,
                    ),
                  ],
                ),
              ),
            ),
            if (isTypeCardExpanded) ...[
              SizedBox(height: 12),
              const Divider(height: 1, color: AppColors.greyE0E0E0),
              // Lista de tipos de Pokemon con checkboxes
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: allTypes.map((type) {
                    final isSelected = tempSelectedTypes.contains(type);
                    final typeColor = PokemonTypeColors.getTypeColor(type);
                    return InkWell(
                      onTap: () {
                        onToggleType(type);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteFFFFFF,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Icono del tipo de Pokémon
                            SvgPicture.asset(
                              PokemonTypeColors.getTypeLogoPath(type),
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                typeColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Nombre del tipo de Pokémon
                            Expanded(
                              child: Text(
                                type_localization.getPokemonTypeTranslatedName(
                                  type,
                                  l10n,
                                ),
                                style: AppTextStyles.textPoppins12Medium424242,
                              ),
                            ),
                            // Checkbox para seleccionar/deseleccionar el tipo
                            Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                onToggleType(type);
                              },
                              activeColor: typeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
