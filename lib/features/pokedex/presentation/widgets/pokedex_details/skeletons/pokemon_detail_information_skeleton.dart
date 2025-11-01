/*
 * @widget PokemonDetailInformationSkeleton
 * @description Skeleton  que agrupa nombre, número (ID), descripción y divisor.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/custom_skeleton_shimmer.dart';

class PokemonDetailInformationSkeleton extends StatelessWidget {
  // Espacio de superposición entre el header y la información
  final double overlapSpace;
  // Número de líneas en la descripción
  final int descriptionLines;
  const PokemonDetailInformationSkeleton({
    super.key,
    required this.overlapSpace,
    this.descriptionLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    // Tema oscuro o claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color base del skeleton
    final base = isDark
        ? AppColors.grey424242.withValues(alpha: 0.5)
        : AppColors.greyE0E0E0;
    // Color de highlight del skeleton
    final highlight = isDark
        ? AppColors.grey616161.withValues(alpha: 0.8)
        : AppColors.greyEEEEEE;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: overlapSpace),
              // Efecto de carga y nombre del Pokémon
              CustomSkeletonShimmer(
                baseColor: base,
                highlightColor: highlight,
                child: Container(
                  height: 30,
                  width: screenWidth * 0.5,
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Efecto de carga y número (ID) del Pokémon
              CustomSkeletonShimmer(
                baseColor: base,
                highlightColor: highlight,
                child: Container(
                  height: 20,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Efecto de carga y tipos del Pokémon
              Wrap(
                spacing: 8,
                children: [
                  _TypeChipSkeleton(baseColor: base, highlightColor: highlight),
                  _TypeChipSkeleton(baseColor: base, highlightColor: highlight),
                ],
              ),
            ],
          ),
        ),
        // Descripción + divisor
        _PokemonDetailDescriptionAndDividerSkeleton(
          lines: descriptionLines,
          baseColor: base,
          highlightColor: highlight,
        ),
      ],
    );
  }
}

class _TypeChipSkeleton extends StatelessWidget {
  // Color base del skeleton
  final Color baseColor;
  // Color de highlight del skeleton
  final Color highlightColor;
  const _TypeChipSkeleton({
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    // Efecto de carga y chip de tipo
    return CustomSkeletonShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: 24,
        width: 74,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

class _PokemonDetailDescriptionAndDividerSkeleton extends StatelessWidget {
  // Número de líneas en la descripción
  final int lines;
  // Color base del skeleton
  final Color baseColor;
  // Color de highlight del skeleton
  final Color highlightColor;
  const _PokemonDetailDescriptionAndDividerSkeleton({
    required this.lines,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    // Anchos predefinidos para las líneas de descripción
    const widths = <double>[0.95, 0.9, 0.96, 0.8, 0.88];
    // Limitar el número de líneas a los anchos predefinidos
    final count = lines.clamp(1, widths.length);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          for (int i = 0; i < count; i++) ...[
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth * widths[i];
                // Efecto de carga y línea de descripción
                return CustomSkeletonShimmer(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 14,
                    width: w,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 12),
          // Divisor
          const Divider(height: 1, color: AppColors.greyE0E0E0),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
