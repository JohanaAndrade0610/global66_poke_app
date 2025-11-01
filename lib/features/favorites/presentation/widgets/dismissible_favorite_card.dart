/*
 * @class DismissibleFavoriteCard
 * @description Widget reutilizable que encapsula la funcionalidad de deslizar para eliminar un favorito.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/pokemon_card.dart';
import '../../../pokedex/domain/entities/pokedex_entity.dart';
import 'delete_favorite_dialog.dart';
import '../../../pokedex/presentation/provider/pokemon_detail_provider.dart';

class DismissibleFavoriteCard extends ConsumerWidget {
  // Pokémon representado en la tarjeta
  final PokedexEntity pokemon;
  // Callback para manejar la eliminación del pokemon de favoritos
  final VoidCallback onDelete;

  const DismissibleFavoriteCard({
    Key? key,
    required this.pokemon,
    required this.onDelete,
  }) : super(key: key);

  /*
  * @method _handleDelete
  * @description Maneja la eliminación del favorito mostrando el diálogo de confirmación.
  * @param context - BuildContext de la aplicación.
  */
  Future<void> _handleDelete(BuildContext context) async {
    final confirmed = await DeleteFavoriteDialog.show(context, pokemon.name);

    if (confirmed == true) {
      onDelete();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      // Clave única para cada pokemon
      key: Key('favorite_${pokemon.id}'),
      direction: DismissDirection.endToStart,
      // Contenedor que se muestra al deslizar la tarjeta
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 8),
        // Diseño del contenedor
        decoration: BoxDecoration(
          color: AppColors.redCD3131,
          borderRadius: BorderRadius.circular(16),
        ),
        // Icono de basurero
        child: SvgPicture.asset(
          'assets/common/favorites/delete_icon.svg',
          width: 38,
          height: 38,
        ),
      ),
      confirmDismiss: (direction) =>
          DeleteFavoriteDialog.show(context, pokemon.name),
      onDismissed: (direction) {
        onDelete();
      },
      // Card del Pokémon
      child: PokemonCard(
        pokemon: pokemon,
        isFavorite: true,
        onTap: () {
          // Navegación a la pantalla de detalles del Pokémon al hacer tap sobre el card
          ref
              .read(pokemonDetailNotifierProvider.notifier)
              .fetchDetail(pokemon.name);
          if (!context.mounted) return;
          context.push('/pokemon/${pokemon.name}');
        },
        onFavoriteTap: () => _handleDelete(context),
      ),
    );
  }
}
