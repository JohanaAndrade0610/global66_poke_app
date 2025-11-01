/*
 * @widget PokedexListSkeleton
 * @description Skeleton  que agrupa los elementos de la lista del pokédex.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/skeleton_shimmer.dart';

class PokedexListSkeleton extends StatelessWidget {
  // Cantidad de elementos en la lista
  final int itemCount;
  const PokedexListSkeleton({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    // Skeleton del card de cada pokémon
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) => const _PokemonCardSkeleton(),
    );
  }
}

class _PokemonCardSkeleton extends StatelessWidget {
  const _PokemonCardSkeleton();

  @override
  Widget build(BuildContext context) {
    // Tema oscuro o claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color base del skeleton
    final base = isDark
        ? AppColors.grey424242.withOpacity(0.5)
        : AppColors.greyE0E0E0;
    // Color base fuerte del skeleton
    final baseStrong = isDark
        ? AppColors.grey616161.withOpacity(0.6)
        : AppColors.greyBDBDBD;
    // Color de highlight del skeleton
    final highlight = isDark
        ? AppColors.grey616161.withOpacity(0.7)
        : AppColors.greyEEEEEE;

    // Efecto de carga y card del Pokémon
    return SkeletonShimmer(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: base.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 116,
        child: Stack(
          children: [
            // Panel derecho que simula el área de imagen
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                    color: baseStrong,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            // Contenido izquierdo (número, nombre y tipos)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // línea de ID
                        Container(
                          width: 60,
                          height: 10,
                          decoration: BoxDecoration(
                            color: base,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // línea de nombre
                        Container(
                          width: 140,
                          height: 16,
                          decoration: BoxDecoration(
                            color: base,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // línea de tipos
                        Row(
                          children: [
                            _ChipSkeleton(color: base),
                            const SizedBox(width: 6),
                            _ChipSkeleton(color: base, width: 56),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Circulito para simular el botón de favorito
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.8),
                    width: 2,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: baseStrong,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipSkeleton extends StatelessWidget {
  // Ancho del tipo
  final double width;
  // Color del tipo
  final Color color;
  const _ChipSkeleton({required this.color, this.width = 68});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
