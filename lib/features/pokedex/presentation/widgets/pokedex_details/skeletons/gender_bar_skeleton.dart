/*
 * @widget PokemonDetailGenderBarSkeleton
 * @description Skeleton de la barra de género (título, barra, porcentajes laterales).
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/skeleton_shimmer.dart';

class PokemonDetailGenderBarSkeleton extends StatelessWidget {
  const PokemonDetailGenderBarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema oscuro o claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Colores base del skeleton
    final base = isDark
        ? AppColors.grey424242.withOpacity(0.5)
        : AppColors.greyE0E0E0;
    // Colores de highlight del skeleton
    final highlight = isDark
        ? AppColors.grey616161.withOpacity(0.8)
        : AppColors.greyEEEEEE;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            // Efecto de cargando y título de la barra de género
            child: SkeletonShimmer(
              baseColor: base,
              highlightColor: highlight,
              child: Container(
                width: 80,
                height: 12,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Efecto de cargando y barra de género
          SkeletonShimmer(
            baseColor: base,
            highlightColor: highlight,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Efecto de cargando y porcentajes laterales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SkeletonShimmer(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: base,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SkeletonShimmer(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Container(
                      width: 44,
                      height: 12,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
              // Efecto de cargando y porcentajes laterales
              Row(
                children: [
                  SkeletonShimmer(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: base,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SkeletonShimmer(
                    baseColor: base,
                    highlightColor: highlight,
                    child: Container(
                      width: 44,
                      height: 12,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
