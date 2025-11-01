/*
 * @widget PokemonDetailInfoGridSkeleton
 * @description Skeleton del grid de info (peso, altura, categoría, habilidad).
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/custom_skeleton_shimmer.dart';

class PokemonDetailInfoGridSkeleton extends StatelessWidget {
  // Número de columnas en la cuadrícula
  final int columns;
  // Número total de elementos en la cuadrícula
  final int itemCount;
  // Espacio entre columnas
  final double columnSpacing;
  // Espacio entre filas
  final double rowSpacing;

  const PokemonDetailInfoGridSkeleton({
    super.key,
    this.columns = 2,
    this.itemCount = 4,
    this.columnSpacing = 22,
    this.rowSpacing = 25,
  });

  @override
  Widget build(BuildContext context) {
    // Tema oscuro o claro para los colores del skeleton
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Colores base del skeleton
    final base = isDark
        ? AppColors.grey424242.withOpacity(0.5)
        : AppColors.greyE0E0E0;
    // Colores de highlight del skeleton
    final highlight = isDark
        ? AppColors.grey616161.withOpacity(0.8)
        : AppColors.greyEEEEEE;
    // Construir filas de la cuadrícula
    List<Widget> rows = [];
    for (int i = 0; i < itemCount; i += columns) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int j = 0; j < columns; j++) ...[
              if (i + j < itemCount)
                Expanded(
                  child: _InfoBoxSkeleton(base: base, highlight: highlight),
                ),
              if (j < columns - 1) SizedBox(width: columnSpacing),
            ],
          ],
        ),
      );
      if (i + columns < itemCount) rows.add(SizedBox(height: rowSpacing));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: rows),
    );
  }
}

class _InfoBoxSkeleton extends StatelessWidget {
  // Color base del skeleton
  final Color base;
  // Color de highlight del skeleton
  final Color highlight;
  const _InfoBoxSkeleton({required this.base, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Efecto cargando y widget del ícono
            CustomSkeletonShimmer(
              baseColor: base,
              highlightColor: highlight,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: base, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(width: 6),
            // Efecto cargando y titulo de la caja de información
            CustomSkeletonShimmer(
              baseColor: base,
              highlightColor: highlight,
              child: Container(
                height: 12,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Efecto cargando y caja de información
        CustomSkeletonShimmer(
          baseColor: base,
          highlightColor: highlight,
          child: Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
