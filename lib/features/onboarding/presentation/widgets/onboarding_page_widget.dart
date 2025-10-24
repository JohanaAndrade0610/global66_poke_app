/*
 * @class OnboardingPageWidget
 * @description Clase encargada de contener las páginas del Onboarding con información sobre la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingPageWidget extends StatelessWidget {
  // Ruta de la imagen de la página
  final String imagePath;
  // Título de la página
  final String title;
  // Descripción de la página
  final String description;

  const OnboardingPageWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Imagen de la página
          Expanded(
            flex: 3,
            child: Center(
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.65, // Máximo 65% del ancho de pantalla
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Título de la página
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.textPoppins26Medium121212,
          ),
          const SizedBox(height: 20),
          // Descripción de la página
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.textPoppins14Regular424242,
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
