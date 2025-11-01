/*
 * @widget PokemonListView
 * @description Widget independiente que muestra la lista de Pokémon en formato de ListView.
 * @autor Angela Andrade
 * @version 1.0 23/10/2025 Creación del widget separado.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/pokedex_entity.dart';
import '../../../../../core/widgets/pokemon_card.dart';
import '../../../../favorites/presentation/provider/favorites_provider.dart';
import '../../provider/pokemon_detail_provider.dart';
import '../../provider/pokedex_provider.dart';

class PokedexListView extends ConsumerWidget {
  // Lista de Pokémon a mostrar
  final List<PokedexEntity> pokemons;
  // Callback para iniciar el widget de loading
  final VoidCallback? onLoadingStart;
  // Callback para finalizar el widget de loading
  final VoidCallback? onLoadingEnd;

  const PokedexListView({
    Key? key,
    required this.pokemons,
    this.onLoadingStart,
    this.onLoadingEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider de favoritos
    final favoritesNotifier = ref.watch(favoritesNotifierProvider.notifier);
    ref.watch(favoritesNotifierProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final metrics = notification.metrics;
          // Disparar la carga de más Pokémon al llegar al final de la lista
          if (metrics.pixels >= metrics.maxScrollExtent) {
            ref.read(pokedexNotifierProvider.notifier).fetchMorePokemons();
          }
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          // Verificar si el Pokémon está en favoritos
          final isFavorite = favoritesNotifier.isFavorite(pokemon.id);
          return GestureDetector(
            onTap: () {
              // Navega de una vez y deja la carga del detalle en segundo plano
              ref
                  .read(pokemonDetailNotifierProvider.notifier)
                  .fetchDetail(pokemon.name);
              if (!context.mounted) return;
              context.push('/pokemon/${pokemon.name}');
            },
            child: PokemonCard(
              pokemon: pokemon,
              isFavorite: isFavorite,
              onFavoriteTap: () {
                // Icono del estado de favorito
                favoritesNotifier.toggleFavorite(pokemon);
              },
            ),
          );
        },
      ),
    );
  }
}
