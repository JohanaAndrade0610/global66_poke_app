/*
 * @class CustomInformation
 * @description Clase encargada de mostrar un widget con información personalizada en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 22/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomInformation extends StatelessWidget {
  final String imagePath; // Ruta de la imagen a mostrar
  final String title; // Título del widget de información
  final String description; // Descripción del widget de información
  final bool showButton; // Indica si se debe mostrar un botón
  final String? buttonText; // Texto del botón
  final VoidCallback?
  onButtonTap; // Callback para el evento de pulsación del botón

  const CustomInformation({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.showButton = false,
    this.buttonText,
    this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagen del widget
          Center(
            child: Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width * 0.45,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          // Título del widget
          Center(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Text(
                title,
                style: AppTextStyles.textPoppins20Semibold333333,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Descripción del widget
          Center(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Text(
                description,
                style: AppTextStyles.textPoppins14Regular4D4D4D,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Botón opcional del widget
          if (showButton && buttonText != null && onButtonTap != null) ...[
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: onButtonTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue1E88E5,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText!,
                    style: AppTextStyles.textPoppins16SemiBoldFFFFFF,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
