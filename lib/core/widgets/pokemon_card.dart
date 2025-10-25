/*
 * @widget PokemonCard
 * @description Widget genérico para mostrar la información de un Pokémon en formato de card reutilizable.
 * @autor Angela Andrade
 * @version 1.0 24/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/pokedex/domain/entities/pokedex_entity.dart';
import 'pokemon_type_label.dart';
import '../theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

class PokemonCard extends StatelessWidget {
  // Información del Pokémon a mostrar
  final PokedexEntity pokemon;
  // Callback al tocar la card
  final VoidCallback? onTap;
  // Callback al tocar el ícono de favorito
  final VoidCallback? onFavoriteTap;
  // Widget opcional al final de la card
  final Widget? trailing;
  // Indica si el Pokémon es favorito
  final bool isFavorite;

  const PokemonCard({
    Key? key,
    required this.pokemon,
    this.onTap,
    this.onFavoriteTap,
    this.trailing,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Internationalización de los textos
    final l10n = AppLocalizations.of(context)!;
    // Tipo principal del Pokémon
    final primaryType = pokemon.types.first;
    // Color de fondo basado en el tipo principal
    final backgroundColor = PokemonTypeColors.getTypeColor(primaryType);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Imagen del pokémon
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        // Transparencia del logo del tipo de Pokémon
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.1),
                            ],
                            stops: const [0.3, 0.7, 1.0],
                          ).createShader(bounds),
                          blendMode: BlendMode.dstIn,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 5,
                              bottom: 5,
                            ),
                            // Logo del tipo de Pokémon
                            child: SvgPicture.asset(
                              PokemonTypeColors.getTypeLogoPath(primaryType),
                              fit: BoxFit.contain,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Imagen del Pokémon
                      Center(
                        child: Image.network(
                          pokemon.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card principal
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
                        // ID del Pokémon
                        Text(
                          'N°${pokemon.id.toString().padLeft(4, '0')}',
                          style: AppTextStyles.textPoppins12Semibold424242,
                        ),
                        const SizedBox(height: 2),
                        // Nombre del Pokémon
                        Text(
                          pokemon.name[0].toUpperCase() +
                              pokemon.name.substring(1),
                          style: AppTextStyles.textPoppins21Semibold121212,
                        ),
                        const SizedBox(height: 6),
                        // Tipos del Pokémon
                        Row(
                          children: pokemon.types.map((type) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right:
                                    pokemon.types.indexOf(type) <
                                        pokemon.types.length - 1
                                    ? 6
                                    : 0,
                              ),
                              child: PokemonTypeLabel(type: type, l10n: l10n),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),
            ),
            // Icono de favorito
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onFavoriteTap,
                behavior: HitTestBehavior.translucent,
                // Circulo externo del ícono
                child: Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  // Fondo interno del ícono
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.grey757575.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    // Ícono de favorito
                    child: SvgPicture.asset(
                      isFavorite
                          ? 'assets/common/favorites/selected_favorite_icon.svg'
                          : 'assets/common/favorites/favorites_icon.svg',
                      width: 14,
                      height: 14,
                    ),
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
