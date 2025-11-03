/*
 * @class RegionsScreen
 * @description Clase encargada de mostrar la pantalla de regiones.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

class RegionsScreen extends StatelessWidget {
  const RegionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Verificar si el tema es oscuro
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen principal de la pantalla
            Center(
              child: Image.asset(
                isDarkMode
                    ? 'assets/regions/regions_image_dark.png'
                    : 'assets/regions/regions_image.png',
                width: MediaQuery.of(context).size.width * 0.45,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            // Título de la pantalla
            Center(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Text(
                  l10n.regionsTitle,
                  style: AppTextStyles.textPoppins20Semibold333333.copyWith(
                    color: isDarkMode
                        ? AppColors.whiteFAFAFA
                        : AppColors.grey333333,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Descripción de la pantalla
            Center(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Text(
                  l10n.regionsDescription,
                  style: AppTextStyles.textPoppins14Regular4D4D4D.copyWith(
                    color: isDarkMode
                        ? AppColors.greyE0E0E0
                        : AppColors.grey4D4D4D,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
