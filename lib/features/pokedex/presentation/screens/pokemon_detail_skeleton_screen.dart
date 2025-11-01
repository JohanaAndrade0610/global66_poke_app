/*
 * @widget PokemonDetailSkeletonScreen
 * @description Pantalla de carga para la pantalla de detalles de un Pokémon.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../widgets/pokedex_details/skeletons/pokemon_header_skeleton.dart';
import '../widgets/pokedex_details/skeletons/pokemon_detail_information_skeleton.dart';
import '../widgets/pokedex_details/skeletons/info_box_grid_skeleton.dart';
import '../widgets/pokedex_details/skeletons/gender_bar_skeleton.dart';

class PokemonDetailSkeletonScreen extends StatelessWidget {
  // Altura del área semicircular superior
  final double semicircleHeight;
  // Espacio de superposición entre el header y la información
  final double overlapSpace;
  const PokemonDetailSkeletonScreen({
    super.key,
    required this.semicircleHeight,
    required this.overlapSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: semicircleHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const SafeArea(top: false, child: SizedBox.shrink()),
              // Skeleton del header
              PokemonHeaderSkeleton(height: semicircleHeight),
              // Overlay para colorear el área de la barra de estado
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).padding.top,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton de la información del Pokémon
                PokemonDetailInformationSkeleton(overlapSpace: overlapSpace),
                const SizedBox(height: 16),
                // Skeleton de la cuadrícula de información adicional
                const PokemonDetailInfoGridSkeleton(),
                const SizedBox(height: 24),
                // Skeleton de la barra de género del Pokémon
                const PokemonDetailGenderBarSkeleton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
