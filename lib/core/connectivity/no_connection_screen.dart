/*
 * @class NoConnectionScreen
 * @description Clase encargada de mostrar la pantalla de no conexión.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../app_theme.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Variable utilizada para las traducciones
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      // Color de la pantalla
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícono de no conexión
                Icon(
                  Icons.signal_wifi_off_rounded,
                  size: 100,
                  color: Color(0xFFBFC5CE),
                ),
                const SizedBox(height: 18),
                // Título de la pantalla
                Text(
                  l10n.no_connection_title,
                  style: AppColors.textPoppins20SemiboldDD000000,
                ),
                const SizedBox(height: 8),
                // Mensaje de la pantalla
                Text(
                  l10n.no_connection_message,
                  style: AppColors.textPoppins14Medium8A000000,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
