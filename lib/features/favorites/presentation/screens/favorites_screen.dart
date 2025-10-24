/*
 * @class FavoritesScreen
 * @description Clase encargada de contener la pantalla de favoritos.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/widgets/custom_information.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../pokedex/domain/entities/pokedex_entity.dart';
import '../provider/favorites_provider.dart';
import '../widgets/dismissible_favorite_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Internationalización de los textos
    final l10n = AppLocalizations.of(context)!;
    // Provider del estado de favoritos
    final favoritesState = ref.watch(favoritesNotifierProvider);
    // Notifier del provider de favoritos
    final favoritesNotifier = ref.watch(favoritesNotifierProvider.notifier);

    return Scaffold(
      // AppBar condicionado a aparecer dependiendo de si hay favoritos
      appBar: favoritesState.maybeWhen(
        loaded: (favorites, _) => favorites.isNotEmpty
            ? AppBar(
                title: Text(l10n.bottomNavigationBarFavorites),
                leading: const BackButton(),
              )
            : null,
        orElse: () => AppBar(
          title: Text(l10n.bottomNavigationBarFavorites),
          leading: const BackButton(),
        ),
      ),
      body: favoritesState.when(
        // Estado de carga
        loading: () => const Center(child: CircularProgressIndicator()),
        // Estado de error
        error: (message) => Center(
          child: CustomInformation(
            imagePath: 'assets/common/information/information_image.png',
            title: l10n.errorInformationTitle,
            description: l10n.errorInformationDescription,
            showButton: false,
          ),
        ),
        // Estado de Pokémon favoritos cargados
        loaded: (favorites, favoriteIds) {
          // Widget de información en caso de no haber favoritos
          if (favorites.isEmpty) {
            return Center(
              child: CustomInformation(
                imagePath: 'assets/common/information/information_image.png',
                title: l10n.favoritesInformationTitle,
                description: l10n.favoritesInformationDescription,
                showButton: false,
              ),
            );
          }
          // Lista de Pokémon favoritos
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              // Convertir FavoriteEntity a PokedexEntity
              final pokemon = PokedexEntity(
                id: favorite.id,
                name: favorite.name,
                imageUrl: favorite.imageUrl,
                types: favorite.types,
              );

              return DismissibleFavoriteCard(
                pokemon: pokemon,
                onDelete: () => favoritesNotifier.toggleFavorite(pokemon),
              );
            },
          );
        },
      ),
      // Footer generico de la aplicación
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          if (index == 0) {
            context.go('/pokedex');
          } else if (index == 1) {
            context.go('/regions');
          } else if (index == 2) {
            // Ventana actual
          } else if (index == 3) {
            context.go('/profile');
          }
        },
      ),
    );
  }
}
