/*
 * @widget GenderBar
 * @description Widget encargado de mostrar la distribución de género de un Pokémon.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme_mode_notifier.dart';
import '../../../../../l10n/app_localizations.dart';

class GenderBar extends ConsumerWidget {
  // Porcentaje de género masculino.
  final double maleRate;
  // Porcentaje de género femenino.
  final double femaleRate;

  const GenderBar({Key? key, required this.maleRate, required this.femaleRate})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Internacionalización de los textos.
    final l10n = AppLocalizations.of(context)!;
    // Sumatoria de los porcentajes para calcular proporciones.
    final total = maleRate + femaleRate;
    // Cálculo del porcentaje de género masculino.
    final malePercent = total > 0 ? maleRate / total : 0.0;
    // Cálculo del porcentaje de género femenino.
    final femalePercent = total > 0 ? femaleRate / total : 0.0;
    // Notificador de modo de tema de la aplicación
    final themeModeNotifier = ref.watch(themeModeNotifierProvider);
    // Estado actual del modo de tema
    final themeMode = themeModeNotifier.value;
    // Verificar si el tema es oscuro
    final isDark = themeMode == ThemeMode.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Título de la barra de género.
        Text(
          l10n.pokedexGender,
          textAlign: TextAlign.center,
          style: AppTextStyles.textPoppins12Medium424242.copyWith(
            color: isDark ? AppColors.greyE0E0E0 : AppColors.grey424242,
          ),
        ),
        const SizedBox(height: 8),
        total == 0
            ? Container(
                height: 12,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.grey424242 : AppColors.greyE0E0E0,
                  borderRadius: BorderRadius.circular(6),
                ),
              )
            : Row(
                children: [
                  // Parte de género masculino en la barra.
                  Expanded(
                    flex: (malePercent * 1000).round(),
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.blue2551C3,
                        borderRadius: malePercent == 1.0
                            ? BorderRadius.circular(6)
                            : malePercent == 0.0
                            ? BorderRadius.zero
                            : const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                      ),
                    ),
                  ),
                  // Parte de género femenino en la barra.
                  Expanded(
                    flex: (femalePercent * 1000).round(),
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.pinkFF7596,
                        borderRadius: femalePercent == 1.0
                            ? BorderRadius.circular(6)
                            : femalePercent == 0.0
                            ? BorderRadius.zero
                            : const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Icono del genero masculino.
                SvgPicture.asset(
                  'assets/pokedex/details/masculine_gender_icon.svg',
                  width: 12,
                  height: 12,
                  color: isDark ? AppColors.greyE0E0E0 : AppColors.grey424242,
                ),
                const SizedBox(width: 4),
                // Porcentaje calculado del género masculino.
                Text(
                  maleRate == 100.0
                      ? '100%'
                      : '${maleRate.toStringAsFixed(1).replaceAll('.', ',')}%',
                  style: AppTextStyles.textPoppins12Medium424242.copyWith(
                    color: isDark ? AppColors.greyE0E0E0 : AppColors.grey424242,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Icono del genero femenino.
                SvgPicture.asset(
                  'assets/pokedex/details/female_gender_icon.svg',
                  width: 12,
                  height: 12,
                  color: isDark ? AppColors.greyE0E0E0 : AppColors.grey424242,
                ),
                const SizedBox(width: 4),
                // Porcentaje calculado del género femenino.
                Text(
                  femaleRate == 100.0
                      ? '100%'
                      : '${femaleRate.toStringAsFixed(1).replaceAll('.', ',')}%',
                  style: AppTextStyles.textPoppins12Medium424242.copyWith(
                    color: isDark ? AppColors.greyE0E0E0 : AppColors.grey424242,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
