/*
 * @class DismissibleFavoriteCard
 * @description Widget reutilizable que encapsula la funcionalidad de deslizar para eliminar un favorito.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/pokemon_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../pokedex/domain/entities/pokedex_entity.dart';
import 'delete_favorite_dialog.dart';

class DismissibleFavoriteCard extends StatelessWidget {
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
      _showDeletedSnackBar(context);
    }
  }

  /*
  * @method _showDeletedSnackBar
  * @description Muestra un SnackBar confirmando la eliminación del favorito.
  * @param context - BuildContext de la aplicación.
  */
  void _showDeletedSnackBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pokemon.name} ${l10n.favoritesDeletedMessage}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        _showDeletedSnackBar(context);
      },
      // Card del Pokémon
      child: PokemonCard(
        pokemon: pokemon,
        isFavorite: true,
        onFavoriteTap: () => _handleDelete(context),
      ),
    );
  }
}
