/*
 * @widget PokedexSkeletonScreen
 * @description Pantalla de carga para la pantalla Pokédex.
 * @autor Angela Andrade
 * @version 1.0 01/11/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import '../widgets/pokedex_list/skeletons/pokedex_filters_skeleton.dart';
import '../widgets/pokedex_list/skeletons/pokedex_list_skeleton.dart';

class PokedexSkeletonScreen extends StatelessWidget {
  const PokedexSkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 10),
        // Skeleton de los filtros
        SafeArea(bottom: false, child: PokedexFiltersSkeleton()),
        // Skeleton de la lista de Pokémon
        Expanded(child: PokedexListSkeleton()),
      ],
    );
  }
}
