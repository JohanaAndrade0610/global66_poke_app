/*
 * @widget PokemonListView
 * @description Widget independiente que muestra la lista de Pokémon en formato de ListView.
 * @autor Angela Andrade
 * @version 1.0 23/10/2025 Creación del widget separado.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/pokedex_entity.dart';
import '../utils/pokemon_type_localization.dart';

class PokemonListView extends StatelessWidget {
  // Lista de Pokémon a mostrar
  final List<PokedexEntity> pokemons;

  const PokemonListView({Key? key, required this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Internacionalización de los textos
    final l10n = AppLocalizations.of(context)!;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        // Obtener el Pokémon actual
        final pokemon = pokemons[index];
        // Obtener el color de fondo basado en el primer tipo del Pokémon
        final primaryType = pokemon.types.first;
        // Obtener el color de fondo basado en el primer tipo del Pokémon
        final backgroundColor = PokemonTypeColors.getTypeColor(primaryType);

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // Contenedor que contiene la imagen del Pokémon y el logo de fondo del tipo
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width *
                        0.37, // Ancho fijo para el área de la imagen
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        // Degradado del color en el logo del tipo de Pokémon
                        Positioned.fill(
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
                        // Imagen del Pokémon centrada
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
              // Contenido del card principal
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información del Pokémon
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
                              final typeNameTranslated =
                                  getPokemonTypeTranslatedName(type, l10n);
                              final typeColor = PokemonTypeColors.getTypeColor(
                                type,
                              );
                              final typeIconPath =
                                  PokemonTypeColors.getTypeLabelLogoPath(type);
                              return Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      pokemon.types.indexOf(type) <
                                          pokemon.types.length - 1
                                      ? 6
                                      : 0,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  // Decoración del contenedor del tipo
                                  decoration: BoxDecoration(
                                    color: typeColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Icono del tipo
                                      SvgPicture.asset(
                                        typeIconPath,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      // Nombre del tipo
                                      Text(
                                        typeNameTranslated,
                                        style: AppTextStyles
                                            .textPoppins11MediumFAFAFA,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Badge de Favorito (esquina superior derecha)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
