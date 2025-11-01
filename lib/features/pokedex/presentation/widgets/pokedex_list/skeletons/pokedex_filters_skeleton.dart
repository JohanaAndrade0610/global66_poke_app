/*
 * @widget PokedexFiltersSkeleton
 * @description Skeleton  que agrupa los filtros de búsqueda del pokédex.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/skeleton_shimmer.dart';

class PokedexFiltersSkeleton extends StatelessWidget {
  const PokedexFiltersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema oscuro o claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color base del skeleton
    final base = isDark
        ? AppColors.grey424242.withOpacity(0.5)
        : AppColors.greyE0E0E0; // color base del skeleton
    // Color de highlight del skeleton
    final highlight = isDark
        ? AppColors.grey616161.withOpacity(0.7)
        : AppColors.greyEEEEEE;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Efecto de carga y barra de búsqueda
      child: SkeletonShimmer(
        baseColor: base,
        highlightColor: highlight,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Efecto de carga y botón de filtros
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
