/*
 * @widget PokemonHeaderSkeleton
 * @description Skeleton  que agrupa los elementos del header de la pantalla de detalles.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/custom_skeleton_shimmer.dart';

class PokemonHeaderSkeleton extends StatelessWidget {
  // Altura del header
  final double height;

  const PokemonHeaderSkeleton({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    // Tema oscuro o claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color base del skeleton
    final base = isDark
        ? AppColors.grey424242.withOpacity(0.45)
        : AppColors.greyE0E0E0;
    // Color de highlight del skeleton
    final highlight = isDark
        ? AppColors.grey616161.withOpacity(0.75)
        : AppColors.greyEEEEEE;

    return SizedBox(
      height: height,
      width: double.infinity,
      // Efecto de carga del header
      child: CustomSkeletonShimmer(
        baseColor: base,
        highlightColor: highlight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.grey424242.withOpacity(0.45)
                : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(180),
              bottomRight: Radius.circular(200),
            ),
          ),
        ),
      ),
    );
  }
}
