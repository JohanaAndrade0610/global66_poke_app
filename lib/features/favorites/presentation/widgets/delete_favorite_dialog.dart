/*
 * @class DeleteFavoriteDialog
 * @description Widget reutilizable para mostrar el diálogo de confirmación de eliminación de favoritos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class DeleteFavoriteDialog extends StatelessWidget {
  // Nombre del Pokémon a eliminar
  final String pokemonName;

  const DeleteFavoriteDialog({Key? key, required this.pokemonName})
    : super(key: key);

  /*
  * @method show
  * @description Método estático para mostrar el diálogo de confirmación.
  * @param context - BuildContext de la aplicación.
  * @param pokemonName - Nombre del Pokémon a eliminar.
  * @returns Future<bool?> True si se confirma, false si se cancela, null si se cierra.
  */
  static Future<bool?> show(BuildContext context, String pokemonName) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return DeleteFavoriteDialog(pokemonName: pokemonName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Internationalización de los textos
    final l10n = AppLocalizations.of(context)!;
    // Nombre del Pokémon con la primera letra en mayúscula
    final capitalizedName = pokemonName.isNotEmpty
        ? '${pokemonName[0].toUpperCase()}${pokemonName.substring(1).toLowerCase()}'
        : pokemonName;

    return AlertDialog(
      // Estilo del diálogo
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.redCD3131.withOpacity(0.3), width: 2),
      ),
      backgroundColor: Colors.white,
      shadowColor: AppColors.redCD3131.withOpacity(0.5),
      elevation: 20,
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // Ícono de advertencia
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.redCD3131.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: AppColors.redCD3131,
              size: 28,
            ),
          ),
        ],
      ),
      // Texto para asegurar la eliminación del pokémon de favoritos
      content: Text(
        '${l10n.favoritesDeleteDialogContent} $capitalizedName?',
        style: AppTextStyles.textPoppins12Medium424242,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        // Botón Cancelar
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
            ),
            // Icono del botón
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pop(false),
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.grey121212,
              ),
              // Texto del botón
              label: Text(
                l10n.favoritesDeleteDialogCancel,
                style: AppTextStyles.textPoppins12SemiBold121212,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
        // Botón Eliminar
        Expanded(
          // Diseño del contenedor
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.redCD3131,
              borderRadius: BorderRadius.circular(50),
            ),
            // Icono del botón
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.delete_rounded, color: Colors.white),
              // Texto del botón
              label: Text(
                l10n.favoritesDeleteDialogConfirm,
                style: AppTextStyles.textPoppins12SemiBoldFFFFFF,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
