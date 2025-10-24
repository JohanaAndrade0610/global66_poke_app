/*
 * @widget PokemonListView
 * @description Widget independiente que muestra la lista de Pokémon en formato de ListView.
 * @autor Angela Andrade
 * @version 1.0 23/10/2025 Creación del widget separado.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pokedex_entity.dart';
import '../../../../core/widgets/pokemon_card.dart';
import '../../../favorites/presentation/provider/favorites_provider.dart';

class PokemonListView extends ConsumerWidget {
  // Lista de Pokémon a mostrar
  final List<PokedexEntity> pokemons;

  const PokemonListView({Key? key, required this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider de favoritos
    final favoritesNotifier = ref.watch(favoritesNotifierProvider.notifier);
    ref.watch(favoritesNotifierProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        // Verificar si el Pokémon está en favoritos
        final isFavorite = favoritesNotifier.isFavorite(pokemon.id);
        return PokemonCard(
          pokemon: pokemon,
          isFavorite: isFavorite,
          onFavoriteTap: () {
            // Icono del estado de favorito
            favoritesNotifier.toggleFavorite(pokemon);
          },
        );
      },
    );
  }
}
