/*
 * @class RegionsScreen
 * @description Clase encargada de mostrar la pantalla de regiones.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../../../l10n/app_localizations.dart';

class RegionsScreen extends StatelessWidget {
  const RegionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen principal de la pantalla
              Center(
                child: Image.asset(
                  'assets/regions/regions_image.png',
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
                    style: AppColors.textPoppins20Semibold333333,
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
                    style: AppColors.textPoppins14Regular4D4D4D,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar generico de la aplicación
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 1) {
            // Onboarding actual
          } else if (index == 0) {
            context.go('/pokedex');
          } else if (index == 2) {
            context.go('/favorites');
          } else if (index == 3) {
            context.go('/profile');
          }
        },
      ),
    );
  }
}
